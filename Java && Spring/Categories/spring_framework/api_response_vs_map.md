## 1. 문제점 (Map 사용 시)

-   `Map<String,Object>`는 키/값 구조라 응답 구조가 **제각각** 될 수
    있음\
    → `"error"` 키를 넣을 때도 있고, `"msg"` 키를 넣을 때도 있고...
    팀원마다 다르게 작성 가능\
-   IDE 자동완성/컴파일 타임 타입체크 불가\
    → 잘못된 키 입력해도 런타임 전까진 모르고, 프론트엔드도 어떤 키가
    오는지 보장 못 함

## 2. 개선점 (ApiResponse 사용 시)

-   `ApiResponse<T>` 레코드를 만들어놓으면, 모든 응답이 **고정된
    구조**를 따름

    ``` json
    { "message": "...", "status": 400, "data": null }
    ```

-   제네릭 `<T>` 덕분에 성공 응답에서는 원하는 데이터 타입을 `data`에
    담고,\
    실패 응답에서는 `Void`를 넣어서 `null`로 표시 가능

-   팀/프론트엔드가 **항상 동일한 JSON 포맷**을 받음 →
    파싱/테스트/문서화가 쉬워짐

------------------------------------------------------------------------

## 3. 코드 비교

### Map 기반

``` java
@ExceptionHandler(Exception.class)
public ResponseEntity<Map<String,Object>> fallback(Exception ex) {
    Map<String,Object> body = new HashMap<>();
    body.put("error", ex.getMessage());
    return ResponseEntity.status(500).body(body);
}
```

응답 예시:

``` json
{ "error": "NullPointerException" }
```

------------------------------------------------------------------------

### ApiResponse 기반

``` java
@ExceptionHandler(Exception.class)
public ResponseEntity<ApiResponse<Void>> fallback(Exception ex) {
    return ResponseEntity
        .status(HttpStatus.INTERNAL_SERVER_ERROR)
        .body(new ApiResponse<>(ex.getMessage(), 500, null));
}
```

응답 예시:

``` json
{ "message": "NullPointerException", "status": 500, "data": null }
```

------------------------------------------------------------------------

## 4. 요약

-   **Map**
    -   자유도 높지만, 팀 프로젝트에서 혼란·불일치 발생
-   **ApiResponse`<T>`{=html}**
    -   타입 안정성 보장
    -   응답 구조 일관성 유지
    -   유지보수와 협업에 유리

👉 따라서 `ResponseEntity<ApiResponse<Void>>` 방식이 권장됨.
