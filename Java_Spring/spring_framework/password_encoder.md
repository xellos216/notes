## 1) Theory

* **표준**: `PasswordEncoder` 빈을 등록하고 회원가입 시 `encode`, 인증 과정은 Spring Security가 `matches` 호출.
* **권장 구현**:

  * 기본은 **BCrypt**. 비용(cost)로 연산 강도 조절.
  * 마이그레이션이나 혼합 포맷 지원은 **DelegatingPasswordEncoder** 사용.
* Favre bcrypt로 만든 해시는 **형식이 `$2a`/`$2b$…`면 Spring의 `BCryptPasswordEncoder`로 검증 가능**. 즉, 기존 데이터 유지 이관 가능.

## 2) Example code

### A. 가장 단순한 표준 설정

```java
@Configuration
public class PasswordEncoderConfig {
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(10); // cost 예: 10~12
    }
}
```

### B. 포맷 혼합/향후 전환 대비(권장)

```java
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
@Configuration
public class PasswordEncoderConfig {
    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
        // {bcrypt}..., {argon2}... 등 접두어로 자동 라우팅
    }
}
```

### C. 회원가입 서비스 사용 예

```java
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository repo;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    public Long register(SignUpRequest req) {
        User user = new User();
        user.setEmail(req.email());
        user.setPassword(passwordEncoder.encode(req.password()));
        return repo.save(user).getId();
    }
}
```

### D. Security와 자동 연동

* `UserDetailsService`를 구현하면 `DaoAuthenticationProvider`가 `PasswordEncoder.matches()`를 자동 호출.

```java
@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final UserRepository repo;

    @Override
    public UserDetails loadUserByUsername(String email) {
        User u = repo.findByEmail(email).orElseThrow(...);
        return User.withUsername(u.getEmail())
                   .password(u.getPassword()) // 인코딩된 해시 저장값
                   .roles("USER").build();
    }
}
```

### E. Favre bcrypt를 써야 하는 예외 케이스

* 모듈이 Spring Security 미사용이거나, 공용 라이브러리로 **순수 유틸**만 제공할 때.
* 그 경우에도 **이름을 `PasswordEncoder`로 만들지 말고** 충돌 방지:

```java
@Component
public class BcryptUtil {
    public String encode(String raw) {
        return BCrypt.withDefaults().hashToString(10, raw.toCharArray());
    }
    public boolean matches(String raw, String encoded) {
        return BCrypt.verifyer().verify(raw.toCharArray(), encoded).verified;
    }
}
```

## 3) Execution and testing method

```bash
# 1) 단위 테스트로 encode/matches 확인
```

```java
@SpringBootTest
class PasswordTests {
    @Autowired PasswordEncoder encoder;

    @Test
    void encode_and_match() {
        String hash = encoder.encode("secret1234");
        assertThat(encoder.matches("secret1234", hash)).isTrue();
    }
}
```

```bash
# 2) 기존 Favre 해시 호환 확인(예: DB에서 하나 꺼내 테스트)
#   해시가 $2a$ 또는 $2b$로 시작하면 Spring의 BCrypt가 검증 가능
```

### 마이그레이션 요약

* 현 DB 해시가 `$2a$…`/`$2b$…` → Spring `BCryptPasswordEncoder`로 그대로 검증 가능. 코드만 표준으로 교체.
* 향후 Argon2로 전환 예정 → `DelegatingPasswordEncoder`로 `{bcrypt}` 저장본을 유지하면서 점진 전환.

---

**결론:** 실무에선 **Spring Security `PasswordEncoder` 빈 + BCrypt**가 기본. 커스텀 유틸은 Security를 쓰지 않는 모듈에서만 예외적으로 사용.
