# 영속성 컨텍스트 (Persistence Context)

## 1. 개념
- **JPA(Java Persistence API)**에서 사용하는 핵심 개념.  
- 애플리케이션과 데이터베이스 사이에서 **엔티티(Entity) 객체를 관리하는 일종의 1차 캐시(메모리 공간)**.  
- `EntityManager`가 관리하는 영역이며, 엔티티 객체의 생명주기를 추적·관리한다.  
- **"엔티티 인스턴스 ↔ 데이터베이스 row"** 간의 연결을 보장한다.

---

## 2. 주요 특징
1. **1차 캐시**  
   - `persist()` 호출 시 DB에 즉시 저장하지 않고 우선 메모리에 저장.  
   - 같은 트랜잭션 내에서 동일한 키(PK)로 조회하면 DB 쿼리를 날리지 않고 캐시된 객체 반환.

2. **동일성 보장**  
   - 같은 영속성 컨텍스트 내에서는 같은 엔티티(PK 기준)는 항상 동일한 객체(==)를 반환.

3. **쓰기 지연(Write-behind)**  
   - `persist()` 호출 시 SQL을 바로 실행하지 않고, SQL 저장소에 모아둠.  
   - 트랜잭션이 `commit()`될 때 한 번에 flush → DB 반영.

4. **변경 감지(Dirty Checking)**  
   - 영속 상태의 엔티티 값이 바뀌면, 트랜잭션 종료 시점에 JPA가 바뀐 부분을 감지해 자동으로 `UPDATE SQL` 실행.

5. **지연 로딩(Lazy Loading)**  
   - 연관된 엔티티는 프록시 객체로 우선 로드 → 실제 접근 시점에 쿼리 실행.

---

## 3. 엔티티 생명주기
1. **비영속(New)**  
   - 엔티티 객체를 생성했지만 영속성 컨텍스트에 저장하지 않은 상태.
   ```java
   Member member = new Member("H");
   ```

2. **영속(Managed)**  
   - `em.persist(member);` 호출 → 영속성 컨텍스트가 관리.  
   - 1차 캐시에 저장, 변경 감지 대상.

3. **준영속(Detached)**  
   - `em.detach(member);` 호출 → 더 이상 관리하지 않음.  
   - 변경 감지 불가.

4. **삭제(Removed)**  
   - `em.remove(member);` 호출 → DB 삭제 예약 상태.

---

## 4. Spring 환경에서의 활용
- **Spring Boot + Spring Data JPA**에서는 일반적으로 `@Transactional` 범위 내에서 영속성 컨텍스트가 열림.  
- 트랜잭션이 끝날 때 `flush + commit` 자동 실행.  
- `Service` 계층에서 비즈니스 로직을 수행할 때, 같은 트랜잭션 내에서는 동일한 영속성 컨텍스트를 사용하므로 캐시 효과와 변경 감지가 유효.

---

## 5. 실무 사용 예시
- **변경 감지 활용**
  ```java
  @Transactional
  public void updateMember(Long id, String newName) {
      Member member = memberRepository.findById(id).orElseThrow();
      member.setName(newName); // 변경 감지
      // 별도 save() 호출 없어도 commit 시 UPDATE 실행
  }
  ```

- **성능 최적화**  
  같은 트랜잭션에서 동일 객체를 여러 번 조회해도 쿼리 한 번만 실행됨 (1차 캐시).  

- **쓰기 지연**  
  여러 `persist()` 호출 후 commit 시점에 batch insert 처리 가능.

---

## 6. 정리
- **Persistence Context = 엔티티를 관리하는 1차 캐시 + 동기화 메커니즘**  
- 이 덕분에 개발자는 SQL 직접 작성 없이 **객체 상태 변화만 신경 쓰면 자동으로 DB 반영**된다.  
- Spring에서는 `@Transactional`과 함께 사용되어 **엔티티 상태 관리와 변경 감지**가 자동으로 적용된다.
