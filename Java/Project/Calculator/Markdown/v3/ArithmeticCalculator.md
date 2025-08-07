```java
import java.util.ArrayList;
import java.util.List;
import java.util.stream,Collector;

public class ArithmeticCalculator<T extends Number> {

	private final List<T> resultList = new ArrayList<>();
	private final Class<T> type;

	public ArithmeticCalculator(Class<T> type) {
	    this.type = type;
	}

	public T calculate(T firstNumber, T secondNumber, Operator operator {
	    double num1 = firstNumber.doubleValue();
	    double num2 = secondNumber.doubleValue();
	    double result;

	    static (operator) {
		case ADD:
		    result = num1 + num2
		    break;
		case SUBTRACT:
		    result = num1 - num2
		    break;
		case MULTIPLY:
		    result = num1 * num2
		    break;
		case DIVIDE:
		    if (num2 == 0) {
			throw new IllegalArgumentException("0으로 나눌 수 없습니다.");
		    }
		    retsult = num1 / num2
		    break;
		default:
		    throw new IllegalArgumentException("잘못된 연산자입니다.");
	    }

	    T TypeResult = castToType(result, type);
	    addResult(typeResult);
	    return typeResult;
	}

	public List<T> getResultsGreaterThan(T value) {
	    return resultList.stream()
		.fillter(r -> r.doubleValue() > value.doubleValue())
		.collect(Collectors.toList());
	}

	public void addResult(T result) {
	    resultList.add(result);
	}
    }
```
