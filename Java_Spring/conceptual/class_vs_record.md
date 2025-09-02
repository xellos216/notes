## 1) 수동 class

```java
public class UserResponse {
    private Long id;
    private String email;
    private String username;
    private String profileImage;

    public UserResponse(Long id, String email, String username, String profileImage) {
        this.id = id;
        this.email = email;
        this.username = username;
        this.profileImage = profileImage;
    }

    public Long getId() { return id; }
    public String getEmail() { return email; }
    public String getUsername() { return username; }
    public String getProfileImage() { return profileImage; }
}
```

## 2) Lombok `@Getter` + `@AllArgsConstructor`

```java
import lombok.Getter;
import lombok.AllArgsConstructor;

@Getter
@AllArgsConstructor
public class UserResponse {
    private Long id;
    private String email;
    private String username;
    private String profileImage;
}
```

## 3) `record`

```java
public record UserResponse(
    Long id,
    String email,
    String username,
    String profileImage
) {}
```

---

## record
* 요청/응답 DTO처럼 생성 후 불변 스냅샷.
* 모든 필드가 필수이며 부분 갱신 없음.
* Java 16+ 환경, Jackson 생성자 바인딩 사용.
* equals/hashCode/toString 자동 생성이 이점.
* 회원 조회 응답 DTO

```java
public record UserResponse(Long id, String email, String username, String profileImage) {}
```

* 로그인 요청 DTO

```java
public record LoginRequest(String email, String password) {}
```

* 페이지 응답 DTO

```java
public record PageResponse<T>(List<T> content, long totalElements, int page, int size) {}
```

* 카프카/이벤트 페이로드(스키마 고정)

```java
public record UserCreatedEvent(Long id, String email, Instant createdAt) {}
```

---

## class 
* 선택적 필드가 많아 빌더나 오버로딩이 필요.
* 라이브러리가 기본생성자나 setter를 요구.
* 직렬화 커스터마이징이 많음.
* 도메인 객체, 세션, 캐시 등 가변 상태 필요.
* JPA 엔티티

```java
@Entity
@Getter @NoArgsConstructor
public class User {
  @Id @GeneratedValue private Long id;
  private String email;
  public void changeEmail(String v){ this.email=v; }
}
```

* 부분 수정 요청(필드 선택적, 빌더 유리)

```java
@Getter @Builder @NoArgsConstructor @AllArgsConstructor
public class UpdateUserRequest {
  private String username;
  private String profileImage;
}
```

* Multipart 업로드 요청(바인딩 제약)

```java
@Getter @Setter @NoArgsConstructor
public class UploadRequest {
  private MultipartFile file;
  private String description;
}
```

* 프레임워크가 기본생성자/세터 요구(레거시 설정, XML 바인딩 등)

```java
@Getter @Setter @NoArgsConstructor
public class LegacyDto {
  private String a;
  private String b;
}
```

* 캐시용 가변 객체, 단계적 조립이 필요한 구조

```java
@Getter @Setter
public class ReportBuilderState {
  private List<String> sections = new ArrayList<>();
}
```
