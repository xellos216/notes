## 1) 개념 설명
- **switch 문(statement)**  
  - 전통 방식. `case`마다 `break`나 `return`을 써서 흐름을 제어.  
  - 메서드 전체에서 제어가 끝나면 `return`으로 값 반환.  
- **switch 표현식(expression, Java 14+)**  
  - `switch`를 *값을 돌려주는 식*으로 사용 가능.  
  - `case X -> 값` : 단일 식이면 그 값이 바로 결과.  
  - `case X -> { ... yield 값; }` : 블록 `{}` 안에서는 `yield`로 결과 반환.  
  - 메서드 전체를 끝내는 `return`과 달리, **switch 식의 결과만 반환**한다.  

즉, `return`은 **메서드 종료**, `yield`는 **switch 표현식 안에서 값 반환**이다.  

---

## 2) 비유
- **switch 문**:  
  "주방에서 요리를 다 하고 나면 곧장 손님에게 서빙(`return`)한다." → 메서드 끝.  
- **switch 표현식**:  
  "주방에서 여러 메뉴 중 하나를 고른 뒤, 그 결과를 주문표에 적어 내보낸다(`yield`) → 나중에 종합해서 서빙."  
- 따라서 `yield`는 "switch 안에서 결과만 선택해 전달"하는 역할이다.  

---

## 3) 예시 코드

### switch 표현식 (`->`, `yield`)
```java
public class CalcExpression {
    public static int calc(int a, int b, String op) {
        return switch (op) {
            case "+" -> a + b;               // 단일 식 → 바로 값 반환
            case "-" -> a - b;
            case "*" -> a * b;
            case "/" -> {
                if (b == 0) throw new ArithmeticException("0으로 나눌 수 없음");
                yield a / b;                 // 블록 사용 시 yield 필요
            }
            default -> throw new IllegalArgumentException("지원하지 않는 연산자");
        };
    }

    public static void main(String[] args) {
        System.out.println(calc(10, 3, "+")); // 13
        System.out.println(calc(10, 3, "/")); // 3
    }
}
```

### 전통적인 switch 문 (`return`)
```java
public class CalcStatement {
    public static int calc(int a, int b, String op) {
        switch (op) {
            case "+": return a + b;
            case "-": return a - b;
            case "*": return a * b;
            case "/":
                if (b == 0) throw new ArithmeticException("0으로 나눌 수 없음");
                return a / b;
            default: throw new IllegalArgumentException("지원하지 않는 연산자");
        }
    }

    public static void main(String[] args) {
        System.out.println(calc(10, 3, "+")); // 13
        System.out.println(calc(10, 3, "/")); // 3
    }
}
```

---

## 4) 최종 요약
- `return`: 메서드 자체를 끝내고 값을 돌려준다.  
- `yield`: **switch 표현식 전용**. `case` 블록에서 switch 결과만 돌려준다.  
- `->` 문법은 switch 표현식에서만 사용. 단일 값은 그대로, 블록 안에서는 `yield`.  
- 장점: 코드 간결, 누락·중복 방지, switch를 값처럼 활용 가능.  

👉 정리: `yield`는 `switch`를 **표현식(값을 가지는 식)**으로 바꿔준 핵심 키워드다.  
