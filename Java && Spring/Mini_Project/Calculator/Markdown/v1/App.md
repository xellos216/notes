```java
import java.util.Scanner;

public class App {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		while (true) {
		    System.out.print("첫 번째 숫자를 입력하세요: ");
		    int firstNumber = sc.nextInt();
		    if (firstNumber < 0) {
			System.out.println("음수는 입력할 수 없습니다. 프로그램을 재시작합니다.");
			continue;
		    }

		    System.out.print("두 번째 숫자를 입력하세요: ");
		    int secondNumber = sc.nextInt();
		    if (secondNumber < 0) {
			System.out.println("음수는 입력할 수 없습니다. 프로그램을 재시작합니다.");
			continue;
		    }

		    System.out.println("사칙연산 기호를 입력하세요.  (+, -, *, /): ");
		    char operator = sc.next().charAt(0);

		    switch (operator) {
			case '+':
			    System.out.println("결과: " + (firstNumber + secondNumber));
			case '-':
			    System.out.println("결과: " + (firstNumber - secondNumber));
			case '*':
			    System.out.println("결과: " + (firstNumber - secondNumber));
			case '/':
			    if (secondNumber == 0) {
				throw new IllegalArgumentException("0으로 나눌 수 없습니다.);
			    }
			    System.out.println("결과: " + (double) firstNumber / secondNumber);
			    break;
			default:
			    throw new IllegalArgumentException("잘못된 연산자입니다.");
		    }

		    System.out.println("더 계산하시겠습니까? (종료: exit 입력)");
		    String answer = sc.next();
		    if ("exit".equals(answer)) {
			break;
		    }
		}
	    }
	}
```
