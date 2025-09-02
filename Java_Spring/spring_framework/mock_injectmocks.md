# mock_and_injectmocks_guide

## 1) Theory
- **@Mock**
  - Mockito가 **가짜 의존성**을 만든다. 실제 구현 없이 호출 시 기본값(null, 0, false, 빈 컬렉션)을 반환한다.
  - 필요 시 `given(...).willReturn(...)` 또는 `when(...).thenReturn(...)`으로 동작을 지정한다.
- **@InjectMocks**
  - 테스트 대상(SUT, System Under Test)을 **생성**하고, 같은 테스트 클래스의 `@Mock`(또는 `@Spy`) 필드를
    **생성자 → 세터 → 필드 순**으로 자동 주입한다.
- **초기화 필수**
  - `@ExtendWith(MockitoExtension.class)`로 Mockito 확장 활성화
    *(또는)* `MockitoAnnotations.openMocks(this)`를 `@BeforeEach`에서 호출.
- **사용 기준**
  - “외부 의존성(리포지토리, HTTP 클라이언트, 인코더 등)은 @Mock”
  - “검증할 대상(Service 등)은 @InjectMocks”
- **구분**
  - `@MockBean`은 **스프링 통합 테스트**에서 스프링 빈을 목으로 대체할 때 사용. 단위 테스트에서는 **@Mock** 사용.
  - `@Spy`는 실제 객체를 감싸 일부만 스텁할 때 사용.

## 2) 이해하기 쉬운 비유
- 팀 프로젝트에서 **진짜 외부 시스템(DB, 메일 서버)** 대신에 **연습용 스텁(가짜 교사)**을 세워서 리허설을 한다고 생각하면 된다.
  - `@Mock` = 대사(응답)를 미리 적어둔 **대역 배우**.
  - `@InjectMocks` = 무대의 **주연 배우**를 올리고, 대역 배우들을 옆에 세워 **리허설**을 진행.

## 3) Example code

### 3-1) 서비스와 의존성
```java
// Production code
class UserService {
    private final UserRepository repo;
    private final PasswordEncoder encoder;

    UserService(UserRepository repo, PasswordEncoder encoder) {
        this.repo = repo;
        this.encoder = encoder;
    }

    public boolean exists(String email) {
        return repo.existsByEmail(email);
    }

    public String register(String email, String rawPw) {
        if (repo.existsByEmail(email)) {
            throw new InvalidRequestException("Email already exists");
        }
        String hash = encoder.encode(rawPw);
        repo.save(new User(email, hash));
        return "OK";
    }
}
```

### 3-2) 단위 테스트(@Mock + @InjectMocks)
```java
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.BDDMockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock UserRepository repo;          // 외부 의존성은 가짜
    @Mock PasswordEncoder encoder;      // 외부 의존성은 가짜
    @InjectMocks UserService service;   // 테스트 대상은 자동 주입되어 생성

    @Test
    void exists_true_when_repo_returns_true() {
        given(repo.existsByEmail("a@a.com")).willReturn(true);

        assertTrue(service.exists("a@a.com"));
        then(repo).should().existsByEmail("a@a.com");
        then(repo).shouldHaveNoMoreInteractions();
    }

    @Test
    void register_success_when_new_email() {
        given(repo.existsByEmail("a@a.com")).willReturn(false);
        given(encoder.encode("Abcd1234!")).willReturn("$bcrypt$hash");
        // save 동작은 반환값이 필요하면 thenReturn(new User(...))로 지정 가능

        String result = service.register("a@a.com", "Abcd1234!");

        assertEquals("OK", result);
        then(repo).should().existsByEmail("a@a.com");
        then(encoder).should().encode("Abcd1234!");
        then(repo).should().save(any(User.class));
    }

    @Test
    void register_throws_when_email_exists() {
        given(repo.existsByEmail("a@a.com")).willReturn(true);

        InvalidRequestException ex = assertThrows(
            InvalidRequestException.class,
            () -> service.register("a@a.com", "Abcd1234!")
        );
        assertEquals("Email already exists", ex.getMessage());
        then(repo).should().existsByEmail("a@a.com");
        then(repo).shouldHaveNoMoreInteractions();
        then(encoder).shouldHaveNoInteractions();
    }
}
```

## 4) Execution and testing method (Ubuntu CLI)
```bash
# Gradle 의존성(예: 스프링 부트 사용 시 기본 포함)
# testImplementation 'org.springframework.boot:spring-boot-starter-test'

./gradlew test --tests '*UserServiceTest'
```
