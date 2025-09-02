## 1. 개념
- 스프링 프레임워크에서 제공하는 트랜잭션 관리 어노테이션.  
- 메서드나 클래스에 붙이면 해당 범위의 DB 작업을 **하나의 트랜잭션**으로 묶는다.  
- 정상적으로 끝나면 **commit**, 도중에 예외가 발생하면 **rollback** 된다.  
- 보통 Service 계층 메서드에 선언한다.  

---

## 2. 동작 방식
1. 메서드 진입 시 트랜잭션 시작.  
2. 메서드 내 DB 작업(JPA, JDBC 등) 실행.  
3.  
   - 정상 종료 → 트랜잭션 commit.  
   - `RuntimeException` 또는 `Error` 발생 → rollback.  
   - 체크 예외(`Exception`)는 rollback 안 함(옵션으로 변경 가능).  

---

## 3. 사용 예시
```java
@Service
public class UserService {
    
    @Transactional
    public void changePassword(Long userId, String newPassword) {
        User user = userRepository.findById(userId)
                                  .orElseThrow(() -> new RuntimeException("User not found"));
        user.changePassword(newPassword);
        // 메서드가 끝나면 자동 commit
        // 중간에 예외 발생하면 rollback
    }
}
```

---

## 4. 주요 속성
- `readOnly = true`  
  - 조회 전용 트랜잭션. 성능 최적화 가능.  
  - 쓰기 작업 시 예외 발생할 수 있음.  

```java
@Transactional(readOnly = true)
public User getUser(Long id) { ... }
```

- `rollbackFor`  
  - 특정 예외에도 rollback 하도록 지정.  
```java
@Transactional(rollbackFor = Exception.class)
public void saveUser(User user) { ... }
```

- `propagation`  
  - 트랜잭션 전파 방식 설정. (기본값: `REQUIRED`)  
  - 예: 이미 실행 중인 트랜잭션이 있으면 합류, 없으면 새로 시작.  

---

## 5. 실행 및 테스트
1. 비밀번호 변경 API 호출 → 성공 시 DB 반영됨.  
2. 메서드 안에서 `RuntimeException` 강제로 발생시켜보기 → DB는 rollback 되어 변경사항 반영되지 않음.  
   ```java
   if (true) throw new RuntimeException("강제 예외");
   ```

---

## 최종 요약
- `@Transactional` = 트랜잭션을 시작·commit·rollback까지 관리해주는 스프링의 핵심 어노테이션.  
- 기본 동작: 메서드 끝나면 commit, 런타임 예외 발생 시 rollback.  
- 속성으로 `readOnly`, `rollbackFor`, `propagation` 등을 세밀하게 제어 가능.  
