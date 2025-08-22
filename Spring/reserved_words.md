## 1) 예약어 개념
- **예약어(Reserved Word)**: 언어/DB가 문법적 의미로 이미 사용하고 있는 단어.  
- 식별자(변수, 클래스, 테이블, 컬럼명 등)로 쓰면 충돌 발생.  
- **Java 예약어**는 클래스/변수/메서드명에서 금지.  
- **SQL 예약어**는 테이블/컬럼명에서 금지.  

---

## 2) Java 예약어 목록 (대표)
```

abstract  assert   boolean  break    byte
case      catch   char     class    const
continue  default do       double   else
enum      extends final    finally  float
for       goto    if       implements import
instanceof int    interface long    native
new       package private  protected public
return    short   static   strictfp super
switch    synchronized this throw   throws
transient try     void     volatile while

```

---

## 3) MySQL 주요 예약어 목록 (대표)
```

ADD   ALL   ALTER   AND   AS   ASC   BETWEEN   BIGINT
BY    CALL  CASE    CHAR  CHECK   COLUMN   CONSTRAINT
CREATE  CROSS  CURRENT\_DATE  DATABASE  DEFAULT
DELETE  DESC  DISTINCT  DROP   ELSE  EXISTS
FALSE   FLOAT  FOREIGN  FROM   GROUP  HAVING
IF   IN   INDEX  INNER  INSERT  INT
INTERVAL  INTO  IS  JOIN  KEY  LIKE
LIMIT  NOT  NULL  ON  OR  ORDER
PRIMARY  REFERENCES  RENAME  REPLACE  RESTRICT
SELECT  SET  SHOW  SMALLINT  TABLE  THEN
TO   TRUE  UNION  UNIQUE  UPDATE  USER
VALUES  VARCHAR  WHEN  WHERE  WITH

````

---

## 4) 교차 주의 단어 (Java 가능 / SQL 예약어)
| 단어     | Java | MySQL |
|----------|------|-------|
| like     | 가능 | 예약어 (`LIKE 'abc%'`) |
| user     | 가능 | 예약어 (계정 관련) |
| order    | 가능 | 예약어 (`ORDER BY`) |
| select   | 가능 | 예약어 (`SELECT ...`) |
| table    | 가능 | 예약어 (`CREATE TABLE`) |

---

## 5) Spring JPA 네이밍 가이드

### 기본 원칙
1. **예약어 피하기** → 이름 자체를 바꿔라. (`like` → `likes`, `user` → `users`)  
2. **명시적 매핑** → `@Table(name="post_likes")`, `@Column(name="order_no")`  
3. **이스케이프 처리**는 최후 수단 (MySQL: `` `like` ``, PostgreSQL: `"user"`)  
4. **일관 규칙**
   - 테이블: 복수형 + snake_case → `post_likes`, `order_items`  
   - 컬럼: snake_case → `status_code`, `order_no`  
   - 제약명: `pk_테이블`, `uk_테이블_컬럼`, `idx_테이블_컬럼`

### Hibernate 네이밍 전략
- Spring Boot 기본: `SpringPhysicalNamingStrategy` → CamelCase → snake_case 변환.  
- 명시적 `@Table/@Column`이 있으면 그 이름 우선.  

---

## 6) 예시 코드

### 안전한 네이밍
```java
@Entity
@Table(name = "post_likes") // 예약어 회피 + 복수형
public class Like {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "member_id") // user 대신 member 사용
    private Long userId;

    @Column(name = "post_id")
    private Long postId;
}
````

### 불가피하게 예약어를 쓸 때 (비권장)

```java
@Entity
@Table(name = "`like`") // MySQL 백틱
public class LikeEscaped {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "`order`") 
    private Integer order;
}
```

---

## 7) 실행 및 테스트 방법

### DB 직접 확인

```sql
-- 실패
CREATE TABLE like (id BIGINT PRIMARY KEY);

-- 성공 (백틱)
CREATE TABLE `like` (id BIGINT PRIMARY KEY);

-- 권장
CREATE TABLE post_likes (id BIGINT PRIMARY KEY);
```

### Spring Boot 실행

```bash
./gradlew bootRun
```

→ Hibernate DDL 생성 로그 확인 (`create table post_likes (...)`).

### 단위 테스트

```java
@SpringBootTest
@Transactional
class LikeRepositoryTest {
    @Autowired EntityManager em;

    @Test
    void save_and_find() {
        Like like = new Like();
        em.persist(like);
        em.flush(); em.clear();

        Like found = em.find(Like.class, like.getId());
        assertNotNull(found);
    }
}
```

```bash
./gradlew test
```

---

## ✅ 최종 요약

* Java 예약어는 IDE가 잡아준다. 문제는 DB 예약어.
* DB 예약어는 테이블/컬럼명에서 충돌하므로 회피가 기본 전략.
* Spring JPA에서는 **복수형 + snake\_case** 네이밍을 팀 규칙으로 정하면 안전하다.
* 이스케이프는 최후 수단. 이식성 떨어짐.
