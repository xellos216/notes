```java
import java.math.BigDecimal;
import java.util.List;
import java.util.Scanner;

public class App {
	public static void main(String[] args) {
	    Scanner sc = new Scanner(System.in);

	    ArithmeticCalculator<BigDecimal> calculator = new ArithmeticCalculator<>(BigDecimal.class);

	    while (true) {
		System.out.print("첫 번째 숫자를 입력하세요: ");
		BigDecimal firstNumber = sc.nextBigDecimal();

		System.out.print("두 번째 숫자를 입력하세요: ");
		BigDecimal secoundNumber = sc.nextBigDecimal();

		System.out.print("사칙연산 기호를 입력하세요. (+, -, *, /): ");
		String symbol = sc.next();
		Operator operator = Operator.fromSymbol(symbol);

		System.out.println("결과: " + calculator.calculate(firstNumber, secondNumber, operator));

		System.out.println("더 계산하시겠습니까? (종료: exit)");
		if ("exit".equals(sc.next())) {
		    break;
		}

		System.out.println("저장된 연산 결과 중 특정 값보다 큰 결과를 조회하시겠습니까? (조회: yes)");
		if ("yes".equals(sc.next))) {
		    System.out.print("기준 값을 입력하세요: ");
		    BigDecimal next = sc.nextBigDecimal();
		    List<BigDecimal> filterResults = calculator.getResultGreaterThan(next);
		    System.out.println("기준 값보다 큰 결과들: " + filteredResults);
		}
	    }
	}
    }
```
