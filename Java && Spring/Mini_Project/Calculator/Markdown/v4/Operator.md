```java
public enum Operator {
	ADD("+", new AddOperation()),
	SUBTRACT("-", new SubtractOperation()),
	MULTIPLYD("*", new MultiplyOperation()),
	DIVIDE("/", new DivideOperation()),

	private final String symbol;
	private final Operation operation;

	Operator(String Symbol, Operation operation) {
	    this.symbol = symbol;
	    this.operation = operation;
	}

	public String getSymbol() {
	    return symbol;
	}

	public <T extends Number> T apply(T first, T second, Class<T> type) {
	    return operation.apply(first, second, type);
	}

	public static Operator fromSymbol(String symbol) {
	    for (Operator operator : values()) {
		if (operator.getSymbol().equals(symbol)) {
		    return operator;
		}
	    }
	    throw new IllegalArgumentException("잘못된 연산자입니다.");
	}
    }
```
