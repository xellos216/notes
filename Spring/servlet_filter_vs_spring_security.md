# Servlet Filter vs Spring Security

## 1. Servlet Filter 개념
- Java EE(Servlet) 기반 웹 애플리케이션에서 **요청(Request)과 응답(Response)을 가로채어 전처리 및 후처리를 수행하는 컴포넌트**.
- DispatcherServlet 이전에 실행되며, 모든 서블릿/리소스에 대해 공통된 로직을 적용할 수 있음.
- 주요 메서드: `init()`, `doFilter()`, `destroy()`

### 주요 활용
- 요청/응답 인코딩 설정 (UTF-8 등)
- 요청/응답 로깅 및 모니터링
- 보안 헤더 강제 삽입 (X-Frame-Options 등)
- 간단한 인증/인가 처리 (예: JWT 파싱)
- CORS 처리

---

## 2. Spring Security 개념
- Spring Framework 위에서 동작하는 **보안 프레임워크**.
- 내부적으로는 여러 개의 Filter로 구성된 FilterChain을 사용하여 **인증(Authentication)**과 **인가(Authorization)**를 처리.
- 세션 관리, CSRF, CORS, 암호화 등 웹 보안 전반을 제공.

### 주요 특징
- 인증/인가 처리 로직 내장 (`UsernamePasswordAuthenticationFilter`, `JwtAuthenticationFilter` 등)
- `HttpSecurity` DSL로 손쉽게 보안 규칙 정의 가능
- 세션 기반/토큰 기반(JWT, OAuth2) 모두 지원
- 플러그인식 확장 구조

---

## 3. 차이점

| 구분 | Servlet Filter | Spring Security |
|------|----------------|-----------------|
| 실행 위치 | Servlet 컨테이너 레벨 (DispatcherServlet 이전) | Spring MVC 환경에서 Security FilterChain으로 동작 |
| 목적 | 공통 전처리/후처리 (인코딩, 로깅 등) | 웹 애플리케이션 보안 (인증·인가·세션 등) |
| 제공 기능 | 단순 (직접 구현 필요) | 통합 보안 기능 제공 |
| 확장성 | 개발자가 직접 구현해야 함 | 다수의 내장 필터와 설정 방식 제공 |
| 실무 사용 | 비즈니스 무관 공통 처리 | 인증/인가 및 전반적 보안 관리 |

---

## 4. 실무 사용 예시

### Servlet Filter
- 모든 요청에 UTF-8 인코딩 적용
- API 요청/응답 로깅
- 요청 처리 시간 측정 성능 모니터링
- 응답 헤더에 보안 옵션 추가
- CORS 허용 처리

### Spring Security
- 로그인 인증 처리 (Form Login, OAuth2, JWT)
- URL 패턴 기반 접근 제어 (예: `/admin/**` 관리자 전용)
- CSRF 방어
- 세션 관리 및 동시 접속 제한
- 역할(Role) 기반 인가 정책

---

## 5. 정리
- **Filter**: 인코딩, 로깅, CORS 같은 **단순 공통 처리**에 사용.
- **Spring Security**: 인증/인가를 포함한 **보안 전반을 책임지는 프레임워크**.
- 실무에서는 두 가지를 혼합 사용. 비보안적 공통 처리는 Filter, 보안은 Spring Security.
