# Spring / JPA / Java 표준 메서드 정리

## **Spring Data JPA**

### `findById`

* **설명**: ID로 엔티티를 조회하며, 결과는 `Optional`로 반환.
* **예시**

```java
User user = userRepository.findById(userId)
    .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));
```

### `findAll`

* **설명**: 모든 엔티티 목록을 조회.
* **예시**

```java
List<Schedule> schedules = scheduleRepository.findAll();
```

### `save`

* **설명**: 엔티티를 저장하거나, 이미 존재하면 수정.
* **예시**

```java
scheduleRepository.save(schedule);
```

### `delete`

* **설명**: 지정한 엔티티를 삭제.
* **예시**

```java
scheduleRepository.delete(schedule);
```

### `deleteById`

* **설명**: ID로 엔티티를 삭제.
* **예시**

```java
userRepository.deleteById(id);
```

### `existsById`

* **설명**: 해당 ID를 가진 엔티티가 존재하는지 여부 확인.
* **예시**

```java
boolean exists = userRepository.existsById(id);
```

---

## **Spring MVC / Servlet**

### `getAttribute`

* **설명**: `HttpServletRequest`에서 속성 값을 가져옴.
* **예시**

```java
Long userId = (Long) request.getAttribute("userId");
```

### `getSession`

* **설명**: 현재 HTTP 세션을 가져오거나 새로 생성.
* **예시**

```java
HttpSession session = request.getSession();
```

### `body`

* **설명**: `ResponseEntity` 응답 본문을 설정.
* **예시**

```java
return ResponseEntity.ok().body(responseDto);
```

### `noContent`

* **설명**: HTTP 204(No Content) 응답을 생성.
* **예시**

```java
return ResponseEntity.noContent().build();
```

### `build`

* **설명**: 빌더 패턴에서 최종 객체를 생성.
* **예시**

```java
return ResponseEntity.noContent().build();
```

---

## **Java 표준 라이브러리 / Stream API**

### `orElseThrow`

* **설명**: `Optional` 값이 없으면 예외를 던짐.
* **예시**

```java
User user = userRepository.findById(id)
    .orElseThrow(() -> new IllegalArgumentException("사용자 없음"));
```

### `map`

* **설명**: Stream 요소를 변환.
* **예시**

```java
List<String> titles = schedules.stream()
    .map(Schedule::getTitle)
    .toList();
```

### `stream`

* **설명**: 컬렉션을 Stream으로 변환.
* **예시**

```java
schedules.stream()
    .map(Schedule::getTitle)
    .toList();
```

### `toList`

* **설명**: Stream 결과를 List로 변환.
* **예시**

```java
List<String> emails = users.stream()
    .map(User::getEmail)
    .toList();
```

### `equals`

* **설명**: 두 객체가 같은지 비교.
* **예시**

```java
if (!user.getId().equals(schedule.getUser().getId())) {
    throw new IllegalArgumentException("권한 없음");
}
```

### `startsWith`

* **설명**: 문자열이 특정 접두사로 시작하는지 확인.
* **예시**

```java
if (email.startsWith("admin")) { ... }
```

### `of`

* **설명**: 불변 컬렉션 또는 Optional 객체 생성.
* **예시**

```java
List<String> list = List.of("A", "B");
```
