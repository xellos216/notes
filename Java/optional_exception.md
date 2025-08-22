## 1. `orElseThrow()`
- `Optional` 클래스가 제공하는 메서드.  
- 값이 있으면 꺼내고, 값이 없으면 지정한 예외를 던진다.  
- 주로 Spring Data JPA의 `findById()`와 함께 사용.  

**예시**
```java
User u = users.findById(userId)
              .orElseThrow(() -> new BadRequestException("USER_NOT_FOUND"));
```

---

## 2. `if` + `throw`
- 전통적인 예외 처리 방식.  
- `Optional`이 없을 때 직접 `null` 체크하거나 `Optional`을 풀어서 검사한다.  

**예시 (Optional 사용)**  
```java
Optional<User> optionalUser = users.findById(userId);

if (optionalUser.isEmpty()) {
    throw new BadRequestException("USER_NOT_FOUND");
}
User u = optionalUser.get();
```

**예시 (null 체크)**  
```java
User u = users.findByIdOrNull(userId); // 가정: null 반환 메서드
if (u == null) {
    throw new BadRequestException("USER_NOT_FOUND");
}
```

---

## 3. `Optional`
- 자바 8부터 도입된 클래스.  
- 값이 있을 수도 있고 없을 수도 있음을 명확하게 표현.  
- `null`을 직접 다루는 것보다 안전하고 의도가 드러남.  

### 주요 메서드
- `isPresent()` / `isEmpty()` → 값 존재 여부 확인.  
- `get()` → 값 꺼내기 (없으면 예외 발생).  
- `orElse(defaultValue)` → 값 없으면 기본값 리턴.  
- `orElseThrow(exceptionSupplier)` → 값 없으면 예외 발생.  
- `ifPresent(consumer)` → 값이 있을 때 실행.  

**예시**
```java
Optional<String> name = Optional.of("Alice");
System.out.println(name.get()); // "Alice"

Optional<String> empty = Optional.empty();
System.out.println(empty.orElse("Unknown")); // "Unknown"
```

---

## 최종 요약
- `orElseThrow()` → `Optional`에서 값이 없을 때 예외를 던지는 깔끔한 문법.  
- `if + throw` → 전통적인 예외 처리 방식. 코드가 길어지지만 명시적임.  
- `Optional` → `null` 안전성을 확보하기 위한 컨테이너 클래스.  

👉 Spring Data JPA의 `findById()`는 `Optional<T>`를 반환하므로, `.orElseThrow()`를 활용하면 가독성과 안정성이 좋아진다.  
