package service;

import java.util.ArrayList;
import java.util.List;
import model.ArithmeticOperator;

public class ArithmeticCalculator {
    private final List<Double> results = new ArrayList<>();

    public double calculate(double a, double b, ArithmeticOperator operator) {
        double result = operator.apply(a, b);
        results.add(result);
        return result;
    }

    public List<Double> getResults() {
        return results;
    }

    public double getMaxResult() {
        return results.stream()
                .mapToDouble(Double::doubleValue)
                .max()
                .orElseThrow(() -> new IllegalStateException("No results found"));
    }

    public double getMinResult() {
        return results.stream()
                .mapToDouble(Double::doubleValue)
                .min()
                .orElseThrow(() -> new IllegalStateException("No results found"));
    }

    public double getSumResult() {
        return results.stream()
                .mapToDouble(Double::doubleValue)
                .sum();
    }
}
