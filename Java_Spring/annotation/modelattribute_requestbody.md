# @ModelAttribute vs @RequestBody 바인딩 정리

Spring MVC에서 `@ModelAttribute`의 바인딩과 `@RequestBody`의 바인딩은 둘 다 **"요청 데이터를 자바 객체에 넣는 것"**이지만, **데이터 소스와 처리 방식**이 다르다.

---

## 1. @ModelAttribute 바인딩
- **데이터 소스**: 쿼리 파라미터, 폼 데이터  
  (예: `application/x-www-form-urlencoded`, `multipart/form-data`)
- **요청 예시**:
  ```
  POST /users/add
  Content-Type: application/x-www-form-urlencoded

  name=Tom&age=20
  ```
- **동작 방식**:
  - 요청 파라미터 이름 ↔ 객체 필드 이름 매칭
  - 타입 변환 후 `setter` 호출
  - 변환 실패 시 예외 던지지 않고 `BindingResult`에 오류 저장
- **컨트롤러 예시**:
  ```java
  @PostMapping("/users/add")
  public String addUser(@Valid @ModelAttribute User user, BindingResult bindingResult) {
      if (bindingResult.hasErrors()) {
          return "form"; // 에러 처리
      }
      return "success";
  }
  ```

---

## 2. @RequestBody 바인딩
- **데이터 소스**: HTTP 요청 Body  
  (주로 JSON, XML)
- **요청 예시**:
  ```
  POST /users/add
  Content-Type: application/json

  {
    "name": "Tom",
    "age": 20
  }
  ```
- **동작 방식**:
  - `HttpMessageConverter`(ex. Jackson) 이용해 JSON/XML → 객체 변환
  - 변환 실패 시 `HttpMessageNotReadableException` 발생
- **컨트롤러 예시**:
  ```java
  @PostMapping("/users/add")
  public ResponseEntity<String> addUser(@Valid @RequestBody User user) {
      return ResponseEntity.ok("success");
  }
  ```

---

## 3. 공통 DTO
```java
public class User {
    @NotBlank
    private String name;

    @Min(1)
    private int age;

    // getter, setter
}
```

---

## 4. 비교 요약

| 구분            | @ModelAttribute                        | @RequestBody                  |
|-----------------|----------------------------------------|-------------------------------|
| 데이터 위치     | URL 쿼리, 폼 필드                      | HTTP Body (JSON/XML)          |
| 지원 ContentType| form-data, x-www-form-urlencoded 등    | application/json, application/xml |
| 실패 처리       | 오류를 `BindingResult`로 직접 확인 가능 | 변환 실패 시 예외 발생        |
| 주 사용처       | 전통적인 웹 폼 처리                    | REST API                      |

---

## 핵심
- **@ModelAttribute**: `key=value` 형태 파라미터 → 자바 객체, `BindingResult`로 오류 직접 제어 가능  
- **@RequestBody**: JSON/XML → 자바 객체, 변환 실패 시 예외 발생  
