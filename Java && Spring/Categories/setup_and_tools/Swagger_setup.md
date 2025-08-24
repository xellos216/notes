# Swagger 설정 분리 방법

운영(prod)에서는 Swagger(`/v3/api-docs`, `/swagger-ui/**`)를 비활성화해야 한다.  
방법은 두 가지가 있다.

---

## 1) 설정 파일 분기 방식

### application.yml (공통)
```yaml
spring:
  profiles:
    active: dev
swagger:
  enabled: true
```

### application-dev.yml
```yaml
spring:
  config:
    activate:
      on-profile: dev
swagger:
  enabled: true
```

### application-prod.yml
```yaml
spring:
  config:
    activate:
      on-profile: prod
swagger:
  enabled: false
```

### Security 설정 분기
```java
@Configuration
@RequiredArgsConstructor
public class SecurityConfig {
    @Value("${swagger.enabled:false}")
    private boolean swaggerEnabled;

    @Bean
    SecurityFilterChain filter(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable());
        http.authorizeHttpRequests(auth -> {
            if (swaggerEnabled) {
                auth.requestMatchers("/v3/api-docs/**","/swagger-ui/**","/swagger-ui.html").permitAll();
            }
            auth.requestMatchers("/auth/**").permitAll();
            auth.anyRequest().authenticated();
        });
        return http.build();
    }
}
```

### 실행
```bash
# 개발 환경 (Swagger 열림)
./gradlew bootRun --args='--spring.profiles.active=dev'

# 운영 환경 (Swagger 닫힘)
./gradlew bootRun --args='--spring.profiles.active=prod'
```

---

## 2) 코드 분기 방식 (@Profile("dev"))

### SwaggerConfig (dev 전용)
```java
@Configuration
@Profile("dev")
public class SwaggerConfig {
    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI().info(new Info().title("Newsfeed API").version("v1.0.0"));
    }

    @Bean
    public GroupedOpenApi publicApi() {
        return GroupedOpenApi.builder().group("newsfeed").pathsToMatch("/**").build();
    }
}
```

### SecurityConfig (공통)
```java
@Configuration
public class SecurityConfig {
    @Bean
    SecurityFilterChain filter(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable());
        http.authorizeHttpRequests(a -> a
            .requestMatchers("/auth/**").permitAll()
            .anyRequest().authenticated());
        return http.build();
    }
}
```

### 실행
```bash
# 개발 환경: Swagger 활성
./gradlew bootRun --args='--spring.profiles.active=dev'

# 운영 환경: Swagger 비활성 (404 반환)
./gradlew bootRun --args='--spring.profiles.active=prod'
```

---

## 요약 비교

- **설정 분기 방식 (yml)**  
  - `swagger.enabled` 플래그로 Swagger 열림/닫힘 제어  
  - 설정 파일에서 관리 가능 (유연함)

- **코드 분기 방식 (@Profile("dev"))**  
  - dev 환경에서만 Swagger Bean 등록  
  - prod 환경에서는 아예 Swagger 경로 미로딩 (404 처리)  
  - **더 안전하고 단순 → 권장**
