package model;

public enum ArithmeticOperator {
    PLUS("+", false,(a, b) -> a + b),
    MINUS("-", false,(a, b) -> a - b),
    MULTIPLY("*", false,(a, b) -> a * b),
    DIVIDE("/", false,(a, b) -> {
        if (b == 0) throw new ArithmeticException("Cannot divide by zero");
        return a / b;
    }),
    POWER("^", false, (a, b) -> Math.pow(a, b)),
    ROOT("sqrt", true,(a, b) -> {
        if (a < 0) throw new ArithmeticException("Cannot take root of negative number");
        return Math.sqrt(a);
    });

    private final String symbol;
    private final boolean unary;
    private final Operation operation;

    ArithmeticOperator(String symbol, boolean unary, Operation operation) {
        this.symbol = symbol;
        this.unary = unary;
        this.operation = operation;
    }

    public double apply(double a, double b) {
        return operation.operate(a, b);
    }

    public String getSymbol() {
        return symbol;
    }

    public boolean isUnary() {
        return unary;
    }

    // 연산 수행을 위한 함수형 인터페이스
    @FunctionalInterface
    private interface Operation {
        double operate(double a, double b);
    }

    // 기호로 Enum을 찾는 유틸 메서드
    public static ArithmeticOperator fromSymbol(String symbol) {
        for (ArithmeticOperator op : values()) {
            if (op.getSymbol().equals(symbol)) {
                return op;
            }
        }
        throw new IllegalArgumentException("Invalid operator: " + symbol);
    }
}



