## 개념_설명

-   **List**
    -   순서 유지. 인덱스 접근 가능. 중복 허용.
    -   대표 구현체: `ArrayList`, `LinkedList`.
-   **Set**
    -   중복 불가. 일반적으로 순서 없음(`HashSet`). 입력 순서 유지가
        필요하면 `LinkedHashSet`, 정렬이 필요하면 `TreeSet`.

## 간단한_비유

-   **List**: 줄 서기 명부. 같은 사람이 여러 번 적힐 수 있고 순번이
    중요.
-   **Set**: 출입증 목록. 같은 카드 중복 등록 불가. 순서는 중요하지
    않음.

## 예시_코드

``` java
import java.util.*;

public class ListSetDemo {
    public static main(String[] args) {
        List<String> list = new ArrayList<>();
        list.add("apple");
        list.add("banana");
        list.add("apple");             // 중복 허용
        System.out.println("List: " + list);     // [apple, banana, apple]
        System.out.println("list[0]: " + list.get(0)); // 인덱스 접근

        Set<String> set = new HashSet<>();
        set.add("apple");
        set.add("banana");
        set.add("apple");              // 중복 제거
        System.out.println("Set: " + set);       // [banana, apple] 등. 순서 비결정
        System.out.println("contains banana? " + set.contains("banana"));
    }
}
```

## 실무_예시

-   **Spring Boot 화이트리스트(URL 중복 방지, 포함 여부 검사 중심)**\

``` java
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.springframework.stereotype.Component;
import java.io.IOException;
import java.util.Set;

@Component
public class AuthFilter implements Filter {
    private static final Set<String> WHITELIST = Set.of("/login", "/signup", "/health");

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        if (WHITELIST.contains(req.getRequestURI())) {
            chain.doFilter(request, response);
            return;
        }
        chain.doFilter(request, response);
    }
}
```

-   **태그 목록 표현(List: 순서 유지·중복 허용이 필요할 때)**\

``` java
public class PostDto {
    private final java.util.List<String> tags;
    public PostDto(java.util.List<String> tags) {
        this.tags = tags;
    }
    public java.util.List<String> getTags() { return tags; }
}
```

-   **중복 없는 권한 세트(Set: 빠른 포함 검사)**\

``` java
public class User {
    private final java.util.Set<String> roles = new java.util.HashSet<>();
    public void addRole(String role) { roles.add(role); }
    public boolean hasRole(String role) { return roles.contains(role); }
}
```

-   **정렬된 고유 코드 집합(TreeSet: 정렬 필요)**\

``` java
java.util.Set<String> codes = new java.util.TreeSet<>();
codes.add("B02"); codes.add("A10"); codes.add("A10");
System.out.println(codes); // [A10, B02]
```

## 최종_요약

-   **List**: 순서 필요, 인덱스 접근, 중복 허용. UI 노출 순서, 히스토리,
    장바구니 수량 같은 케이스.
-   **Set**: 중복 제거, 포함 여부 중심, 보통 무순서. 화이트리스트, 권한,
    고유 키 집합 같은 케이스.
-   필요에 따라 `LinkedHashSet`(입력 순서 유지)과 `TreeSet`(정렬) 선택.
