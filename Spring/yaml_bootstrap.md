## 1) Theory

* 실무는 기본적으로 `application.yml`(공통) + `application-<profile>.yml`(dev/test/prod)로 시작한다.
* 실행 시 적용: `application.yml` + **활성 프로필 한 개**가 머지된다. 충돌 없음. 같은 키는 프로필 파일이 우선.
* 원칙: 공통은 “불변 기본값”, 프로필 파일은 “환경 차이(DB, 포트, 로깅, 보안, 문서 노출)”만 둔다.
* `spring.config.activate.on-profile`을 사용해 각 파일의 대상 프로필을 명시한다.

## 2) Example code

### 파일 배치

```
src/main/resources/
 ├─ application.yml
 ├─ application-dev.yml
 ├─ application-test.yml
 └─ application-prod.yml
```

### application.yml (공통 최소 골격)

```yaml
spring:
  application:
    name: newsfeed-app

  jpa:
    open-in-view: false
    hibernate:
      ddl-auto: update
    properties:
      hibernate.format_sql: true
  datasource:
    # 각 프로필에서 덮어씀. 환경변수로도 대체 가능.
    url: ${SPRING_DATASOURCE_URL:jdbc:mysql://localhost:3306/newsfeed}
    username: ${SPRING_DATASOURCE_USERNAME:app}
    password: ${SPRING_DATASOURCE_PASSWORD:app}

management:
  endpoints:
    web:
      exposure:
        include: "health,info"   # dev에서 확장

springdoc:
  paths-to-exclude: /error, /actuator/**
```

### application-dev.yml (개발)

```yaml
spring:
  config:
    activate:
      on-profile: dev

  datasource:
    url: ${SPRING_DATASOURCE_URL:jdbc:mysql://127.0.0.1:3306/newsfeed_dev?serverTimezone=UTC}
    username: ${SPRING_DATASOURCE_USERNAME:dev_user}
    password: ${SPRING_DATASOURCE_PASSWORD:dev_pass}

  jpa:
    hibernate:
      ddl-auto: update
  output:
    ansi:
      enabled: always

management:
  endpoints:
    web:
      exposure:
        include: "*"

# 개발 편의를 위한 문서/보안 범위
server:
  port: 8080
springdoc:
  packages-to-scan: hello.newsfeed   # 필요 시
```

### application-test.yml (테스트)

```yaml
spring:
  config:
    activate:
      on-profile: test

  datasource:
    url: jdbc:h2:mem:testdb;MODE=MySQL;DB_CLOSE_DELAY=-1
    username: sa
    password:
  jpa:
    hibernate:
      ddl-auto: create-drop
```

### application-prod.yml (운영)

```yaml
spring:
  config:
    activate:
      on-profile: prod

  datasource:
    url: ${SPRING_DATASOURCE_URL}
    username: ${SPRING_DATASOURCE_USERNAME}
    password: ${SPRING_DATASOURCE_PASSWORD}

  jpa:
    hibernate:
      ddl-auto: validate

server:
  port: ${SERVER_PORT:8080}

logging:
  level:
    root: INFO
```

### IntelliJ 설정

* 기본은 `application.yml`만 적용.
* Run/Debug Configurations → VM options:

  * dev: `-Dspring.profiles.active=dev`
  * test: `-Dspring.profiles.active=test`
  * prod: `-Dspring.profiles.active=prod`

### 빠른 스캐폴딩(선택)

```bash
cat > src/main/resources/application.yml <<'Y'; cat > src/main/resources/application-dev.yml <<'D'; cat > src/main/resources/application-test.yml <<'T'; cat > src/main/resources/application-prod.yml <<'P'
# 위 예시 내용 각각 붙여넣기
Y
D
T
P
```

## 3) Execution and testing method

```bash
# dev
./gradlew bootRun --args='--spring.profiles.active=dev'
curl -I http://localhost:8080/v3/api-docs
curl -s http://localhost:8080/actuator/health

# test
./gradlew test -Dspring.profiles.active=test

# prod(로컬 검증)
./gradlew bootRun --args='--spring.profiles.active=prod'
```

요약: 실무는 시작 시 **3개 프로필 파일을 템플릿으로 만들어 둔다**. 공통은 최소화, 차이만 프로필에서 오버라이드. 기본 생성된 `application.yml`을 기준으로 복붙 후, 위 템플릿처럼 키만 환경별로 바꾸면 된다.
