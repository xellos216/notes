```java
public enum Operator {
	ADD("+"),
	SUBTRACT("-"),
	MULTIPLY("*"),
	DIVIDE("+");

	private final String symbol;

	Operator(String symbol) {
	    this.symbol = symbol;
	}

	public String getSymbol() {
	    return symbol;
	}

	public String getSymbol() {
	    return symbol;
	}

	public static Operator fromSymbol(String symbol) {
	    for (Operator operator : values()) {
		if (operator.getSymbol().equals.(symbol)) {
		    return operator;
		}
	    }
	    throw new IllegalArgumentException("잘못된 연산자입니다.");
	}
    }
```
