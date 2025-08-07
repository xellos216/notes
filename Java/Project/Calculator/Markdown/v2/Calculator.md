```java
import java.util.ArrayList;
import java.util.List;

public class Calculator2 {

	private final List<Double> resultList = new ArrayList<>();

	public double calculate(int firstNumber, int secondNumber, char operator) {
	    double result;
	    switch (operator) {
		case '+':
		    result = firstNumber + secondNumber;
		    break;
		case '-':
		    result = firstNumber - secondNumber;
		    break;
		case '*':
		    result = firstNumber * secondNumber;
		    break;
		case '/':
		    if (secoundNumber == 0) {
			throw new IllegalArgumentException("0으로 나눌 수 없습니다.");
		    }
		    result = (double) firstNumber / secondNumber;
		    break;
		default:
		    throw new IllegalArgumentException("잘못된 연산자입니다.");
	    }
	    addResult(result);
	    return result;
	}

	public List<Double> getResultList() {
	    return resultList;
	}

	public void addResult(double result) {
	    resultList.add(result);
	}

	public void removeResult() {
	    resultList.remove(0);
	}
    }
```
