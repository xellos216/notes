# Java `record` 개념 정리

## 1. 기본 개념

- `record`는 Java 16부터 정식 추가된 **데이터 전용 클래스** 문법이다.
- 불변(immutable) 객체를 간결하게 정의할 때 사용한다.
- 자동으로 생성되는 요소:
  - 모든 필드를 초기화하는 생성자
  - `getter` (필드명과 같은 이름의 메서드)
  - `equals()`, `hashCode()`, `toString()`
- 모든 필드는 `final`로 고정된다. 즉 생성 시점 이후 변경 불가.
- 상속 불가. 자동으로 `final`이다.
- `class`와 달리 보일러플레이트 코드(생성자, getter, equals, hashCode, toString)를 직접 안 써도 된다.

---

## 2. 예시 비교

### 일반 클래스

```java
public class ApiResponse<T> {
    private final int status;
    private final String message;
    private final T data;

    public ApiResponse(int status, String message, T data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }

    public int getStatus() { return status; }
    public String getMessage() { return message; }
    public T getData() { return data; }

    @Override
    public boolean equals(Object o) { ... }
    @Override
    public int hashCode() { ... }
    @Override
    public String toString() { ... }
}
```

### 동일 기능 `record`

```java
public record ApiResponse<T>(int status, String message, T data) {}
```

자동으로 위 기능이 모두 생성된다.

---

## 3. 특징 요약

- **용도**: DTO, 응답/에러 래퍼, 값 객체(Value Object) 등 데이터 전달에 최적.
- **제한**:
  - 필드 변경 불가 → setter 불가능.
  - 상속 불가.
- **장점**: 코드 간결, 명확한 의도(“나는 단순 데이터 홀더”).

---

## 4. 현재 코드에 적용된 이유

- `ApiResponse`, `ErrorPayload`, `ErrorResponse`는 불변 데이터 전달용 객체다.
- 변경될 필요가 없으니 `record`로 정의하면 코드가 훨씬 간결해지고 의도가 명확해진다.
- SOLID 원칙과 Clean Architecture 관점에서, “순수 데이터 전달 객체”임을 드러내기에 적합하다.

---

## 정리

`record` = **불변 데이터 클래스 자동 생성기**.
즉, `private final`, 생성자, `this.필드 = 매개변수`, `getter`를 다 안 써도 된다.
응답/에러 래퍼 같은 DTO 계층에 딱 맞는 선택이다.

