# 🧱 Spring Boot Backend Structure – Lego Block Analogy
Spring Boot 백엔드는 다양한 기능 블럭(@RestController, @Service, @Repository 등)을 목적에 맞게 조립하여 웹 애플리케이션을 구성합니다. 이 구조는 마치 기능별 레고 블럭을 이해하고 연결하는 것과 같습니다.

---

## ✅ 전체 구조
```
[ 사용자 요청 ] ─▶ [🔵 Controller 블럭] ─▶ [🟡 Service 블럭] ─▶ [🟠 Repository 블럭] ─▶ [🟤 Database]

                            │                           │
                            ▼                           ▼
                    [🟢 DTO 블럭]                 [🟥 Entity 블럭]

                            ▲
                            │
                    [⚙️ Config 블럭]
```

---

## ✅ 각 블럭 설명
### 🔵 Controller 블럭
- 어노테이션: `@RestController`, `@GetMapping`, `@PostMapping` 등
- 역할: HTTP 요청을 받아서 Service에 전달

### 🟡 Service 블럭
- 어노테이션: `@Service`
- 역할: 비즈니스 로직 처리

### 🟠 Repository 블럭
- 어노테이션: `@Repository`, `JpaRepository`
- 역할: DB와의 CRUD 처리

### 🟤 Database
- 실체: MySQL, PostgreSQL 등
- 역할: Entity와 매핑된 실제 데이터 저장소

### 🟢 DTO 블럭
- 클래스: `UserRequestDto`, `UserResponseDto` 등
- 역할: Controller ↔ Service 간 데이터 전송

### 🟥 Entity 블럭
- 어노테이션: `@Entity`
- 역할: DB 테이블 구조 정의

### ⚙️ Config 블럭
- 어노테이션: `@Configuration`, `@Bean` 등
- 역할: 설정, 보안, 의존성 주입, 기타 환경 구성

---

## ✅ 작동 흐름 예시

1. 사용자가 `/users/10` 요청
2. Controller가 요청 받고 PathVariable 추출
3. Service에 ID 전달
4. Service가 Repository에 DB 조회 요청
5. Repository가 Entity 조회
6. Service가 DTO로 변환
7. Controller가 DTO를 반환

---

## ✅ 코드 예시

### 📍 Controller
```java
@RestController
public class UserController {
    private final UserService userService;
    public UserController(UserService userService) { this.userService = userService; }

    @GetMapping("/users/{id}")
    public UserResponseDto getUser(@PathVariable Long id) {
        return userService.findUser(id);
    }
}
```

### 📍 Service
```java
@Service
public class UserService {
    private final UserRepository userRepository;
    public UserService(UserRepository userRepository) { this.userRepository = userRepository; }

    public UserResponseDto findUser(Long id) {
        User user = userRepository.findById(id).orElseThrow();
        return new UserResponseDto(user);
    }
}
```

### 📍 Repository
```java
@Repository
public interface UserRepository extends JpaRepository<User, Long> {}
```

### 📍 Entity
```java
@Entity
public class User {
    @Id @GeneratedValue
    private Long id;
    private String username;
}
```

---

## ✅ 요약
| 요소       | 역할                             |
|------------|----------------------------------|
| 블럭       | 각각의 어노테이션, 클래스, 객체들   |
| 조립 방법   | 계층 구조, DI, 설정               |
| 조립 순서   | 요청 → 컨트롤러 → 서비스 → 레포지토리 → DB |
| 커스터마이징 | 필요 시 블럭을 직접 정의하거나 바꿀 수 있음 |
