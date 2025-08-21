# 바인딩, 매핑, 게터, 세터 정리

## 1. 바인딩 (Binding)
### 개념
외부에서 들어온 데이터(JSON, Form 등)를 **Java 객체의 필드에 자동으로 채워 넣는 과정**  
→ 주로 **컨트롤러 단에서 요청(Request)**을 받을 때 발생.  

### 비유
택배 기사가 주소 라벨(JSON 키 이름)을 보고 집 안의 방(필드)에 물건(값)을 넣어주는 것.  

### 예시
```json
{ "nickname": "H", "password": "1234" }
```
```java
public class SignupRequest {
    private String nickname;
    private String password;

    // 기본 생성자 + setter 필요
}
```
```java
@PostMapping("/signup")
public void signup(@RequestBody SignupRequest request) {
    // JSON → SignupRequest 객체로 자동 바인딩됨
}
```

---

## 2. 매핑 (Mapping)
### 개념
**한 객체의 데이터를 다른 객체로 옮겨 담는 과정**  
→ 주로 **Entity ↔ DTO 변환**에서 발생.  

### 비유
거실에 있던 가구(Entity 데이터)를 다른 방(DTO)으로 옮겨놓는 과정.  

### 예시
```java
public class UserEntity {
    private Long id;
    private String email;
    private String password;
}

public class UserResponseDto {
    private String email;

    public UserResponseDto(UserEntity user) {
        this.email = user.getEmail(); // 매핑
    }
}
```

---

## 3. Getter
### 개념
객체 안에 있는 필드 값을 **외부에서 읽을 수 있게 해주는 메서드**.  
→ 보통 `get필드명()` 형태.  

### 비유
방 안에 있는 물건을 직접 꺼내지 않고, **창문을 열어 안을 들여다보는 행위**.  

### 예시
```java
UserResponseDto dto = new UserResponseDto(user);
String email = dto.getEmail(); // 값 읽기
```

---

## 4. Setter
### 개념
객체의 필드 값을 **외부에서 수정할 수 있게 해주는 메서드**.  
→ 보통 `set필드명(값)` 형태.  

### 비유
방 안에 새 가구를 들여놓는 **문**을 여는 행위.  

### 예시
```java
SignupRequest req = new SignupRequest();
req.setNickname("H");
req.setPassword("1234"); // 값 변경
```

---

## 최종 요약
- **바인딩** = JSON/Form → DTO (택배가 자동으로 집 방에 들어감)  
- **매핑** = Entity ↔ DTO 변환 (거실 가구를 서재로 옮김)  
- **Getter** = 값 읽기 (창문 열어 안을 봄)  
- **Setter** = 값 수정 (문 열고 물건 넣음)  
