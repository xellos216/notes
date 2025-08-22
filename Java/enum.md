## 1) 개념 (Theory)
- **정의**: `enum`은 *열거형(enumeration)* 으로, **한정된 상수 집합**을 정의하는 특별한 타입이다.  
- **특징**  
  1. 상수 값들을 **타입으로 강제**할 수 있다. (`ErrorCode` 타입이면 반드시 정의된 상수 중 하나만 사용 가능)  
  2. 상수마다 **필드와 생성자 인자**를 가질 수 있다.  
  3. `switch` 문에서 **enum 상수 자체로 직접 분기** 가능하다. → `enum` 전용 문법.  
  4. 런타임에 새로운 인스턴스 생성 불가 → 안전한 상수 관리.  
- **비교**  
  - `static final` 상수: 값만 보관. `switch`에서 직접 분기 불가.  
  - `enum`: 언어 차원에서 집합을 고정. `switch` 지원. 타입 안정성 + 가독성 확보.  

---

## 2) 비유 (Analogy)
- **신호등**: 빨강, 노랑, 초록만 있다.  
  - 문자열 `"RED"`, `"YELLOW"`, `"GREEN"` 으로 표현하면 `"REDD"` 같은 오타도 통과된다.  
  - `enum Light { RED, YELLOW, GREEN }` 로 정의하면 오타는 컴파일 에러로 걸린다.  
- **식당 메뉴판**: 메뉴판에 적힌 음식만 주문 가능. `enum Menu { RAMEN, SUSHI, BULGOGI }`  
  - 메뉴판에 없는 `"Pizza"`는 주문 불가.  

---

## 3) 예시 코드 (Example code)

### 에러 코드 관리
```java
public enum ErrorCode {
    BAD_REQUEST("C400", 400, "잘못된 요청"),
    UNAUTHORIZED("A401", 401, "인증 필요");

    public final String code;
    public final int status;
    public final String message;

    ErrorCode(String code, int status, String message) {
        this.code = code;
        this.status = status;
        this.message = message;
    }
}

public class EnumTest {
    public static void main(String[] args) {
        ErrorCode e = ErrorCode.BAD_REQUEST;
        System.out.println(e.code);     // C400
        System.out.println(e.status);   // 400
        System.out.println(e.message);  // 잘못된 요청

        // enum + switch + 상수 이름 직접 분기 (enum 전용 문법)
        switch (e) {
            case BAD_REQUEST -> System.out.println("400 에러 처리");
            case UNAUTHORIZED -> System.out.println("401 에러 처리");
        }
    }
}
```

### 신호등 예시
```java
public enum TrafficLight {
    RED, YELLOW, GREEN
}

public class TrafficTest {
    public static void main(String[] args) {
        TrafficLight t = TrafficLight.RED;

        switch (t) {
            case RED -> System.out.println("멈춤");
            case YELLOW -> System.out.println("주의");
            case GREEN -> System.out.println("출발");
        }
    }
}
```

---

## 4) 실행 및 테스트 (Execution and testing method)
```bash
javac ErrorCode.java EnumTest.java TrafficLight.java TrafficTest.java
java EnumTest
java TrafficTest
```

출력 예:
```
C400
400
잘못된 요청
400 에러 처리

멈춤
```

---

## 5) 요약
- `enum` = 한정된 상수 집합 + 타입 안정성 + 생성자/필드로 부가정보 관리.  
- **비유**: 신호등, 메뉴판 → 정해진 값만 사용 가능.  
- **특수 문법**: `switch(enum)`은 enum 전용. 상수 이름으로 직접 분기 가능. 일반 클래스 상수는 불가.  
- **활용**: 에러 코드, 상태 코드, 요일, 방향(NORTH/EAST/SOUTH/WEST), 메뉴 선택 등.  

---

👉 결론: `enum`은 단순 상수 모음이 아니라, **상수 집합을 타입으로 고정**하고, **switch와 결합해 안정적이고 가독성 좋은 분기 처리까지 지원하는 특별한 문법 구조**다.  
