# 📚 핵심 개념 정리

Spring Boot 기반 백엔드 프로젝트를 구현하기 전에 반드시 이해하고 넘어가야 할 핵심 개념들을 정리한 문서입니다.

---

## 1. 🧱 3 Layer Architecture (3계층 구조)

| 계층 | 역할 |
|------|------|
| Controller | HTTP 요청을 받아 처리하고 응답을 반환하는 입구 |
| Service | 비즈니스 로직 수행 (실질적인 작업 담당) |
| Repository | DB와 직접 통신 (JPA를 통해 쿼리 처리) |

> 역할을 분리함으로써 유지보수, 테스트, 확장성이 높아짐

---

## 2. Entity란?

> DB 테이블을 자바 객체로 표현한 클래스

### 예시: Schedule

```java
@Entity
public class Schedule {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String content;
    private String writer;
    private String password;
    private LocalDate date;
}
```

| 자바 필드 | DB 컬럼 |
|-----------|---------|
| id        | id (PK, Auto Increment) |
| title     | title (VARCHAR) |
| ...       | ... |

- `@Entity` → JPA가 이 클래스를 테이블로 인식
- `@Id` → 기본키 지정
- `@GeneratedValue` → 자동 증가 전략

---

## 3. 📦 DTO (Data Transfer Object)

### ❓ 왜 필요한가?
- 엔티티를 그대로 노출할 경우 보안 문제 발생 (예: 비밀번호 포함됨)
- 유지보수가 어려워짐

### 🛠 예시

```java
// 요청 DTO
public class ScheduleRequestDto {
  private String title;
  private String content;
  private String writer;
  private String password;
}

// 응답 DTO
public class ScheduleResponseDto {
  private Long id;
  private String title;
  private String content;
  private LocalDate date;
  private String writer;
  // 비밀번호는 포함하지 않음
}
```

---

## 4. 🧾 ResponseEntity

Spring에서 API 응답을 명확하고 유연하게 반환할 수 있는 클래스

```java
return ResponseEntity.status(HttpStatus.OK).body(responseDto);
```

- HTTP 상태코드와 데이터를 함께 응답할 수 있음
- JSON, XML 등 다양한 포맷으로 응답 가능

---

## 5. 🗂 ERD (Entity Relationship Diagram)

- 데이터베이스의 테이블 구조와 관계를 시각화한 도식
- 예: `Schedule`(일정) - `Comment`(댓글)는 1:N 관계
- ERD는 README.md에 이미지 또는 텍스트로 작성

---

## 6. 📬 어노테이션 차이점

| 어노테이션 | 설명 | 사용 예시 |
|------------|------|-----------|
| `@RequestParam` | 쿼리 파라미터 | `/schedule?id=1` |
| `@PathVariable` | URL 경로 변수 | `/schedule/1` |
| `@RequestBody` | JSON 본문 객체 | `POST /schedule`의 요청 본문 |

---

## 7. 📄 API 명세서란?

- API의 요청/응답 구조를 정리한 문서
- 어떤 URL에 어떤 값을 보내면 어떤 응답이 오는지 명시

### 예시

```
POST /schedule

요청:
{
  "title": "회의",
  "writer": "홍길동",
  "password": "1234"
}

응답:
{
  "id": 1,
  "title": "회의",
  "writer": "홍길동"
}
```

---

## 8. 🧪 Postman

- 다양한 HTTP 메서드(GET, POST, PUT, DELETE)를 테스트할 수 있는 도구
- JSON 형태의 요청/응답 테스트 가능
- 프론트 없이 백엔드 API만으로도 기능 검증 가능
