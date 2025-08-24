# @SessionAttribute 정리

## 1. 정석적인 개념 설명
`@SessionAttribute`는 스프링 MVC에서 **HTTP 세션에 저장된 데이터를 컨트롤러 메서드 파라미터로 바로 바인딩하는 어노테이션**이다.  
세션에 특정 키 이름으로 저장된 객체를 가져와서, 해당 타입 변수로 바로 사용할 수 있게 해준다.  

- 위치: 컨트롤러 메서드 파라미터  
- 대상: 세션(`HttpSession`)에 이미 저장된 값  
- 속성:  
  - `name`(또는 value): 세션에 저장된 속성 이름(키)  
  - `required`: 기본값 `true`. 없으면 예외, `false`로 하면 값 없을 시 `null`  

---

## 2. 비유로 이해하기
세션을 **보관함(locker)**이라고 생각하자.  
- `setAttribute("user", userObj)`는 **보관함에 `"user"`라는 이름표를 붙여 물건(객체)을 넣는 것**이다.  
- `@SessionAttribute("user")`는 그 **이름표가 붙은 물건을 꺼내 달라고 컨트롤러에 부탁하는 것**이다.  

즉, `@SessionAttribute("키이름")` 안에 들어가는 값은 “보관함에 붙여둔 이름표”와 동일해야 한다.  

---

## 3. 간단한 예시 코드

```java
// 세션에 값 저장 (로그인 시)
session.setAttribute("loginUser", new User("hong", "hong@test.com"));

// 세션 값 꺼내 쓰기 (컨트롤러에서)
@GetMapping("/mypage")
public String myPage(@SessionAttribute(name = "loginUser", required = false) User user) {
    if (user == null) {
        return "redirect:/login";
    }
    return "mypage";
}
```

---

## 4. 실무에서 사용되는 곳
- **로그인 사용자 정보 유지**: 로그인한 유저 객체를 세션에 저장해두고, 이후 컨트롤러에서 바로 꺼내 사용.  
- **장바구니 처리**: 쇼핑몰에서 장바구니 객체를 세션에 저장해두고, 결제 단계마다 그대로 불러옴.  
- **다단계 입력 폼**: 여러 페이지에 걸쳐 입력하는 폼 데이터(예: 회원가입 3단계)를 세션에 넣고, 마지막 단계에서 한 번에 처리.  

---

👉 요약: `@SessionAttribute`는 세션 보관함에서 **이름표가 맞는 물건을 꺼내는 편리한 도구**다.  
실무에서는 주로 로그인 정보나 사용자의 지속 상태 데이터를 불러올 때 쓴다.  
