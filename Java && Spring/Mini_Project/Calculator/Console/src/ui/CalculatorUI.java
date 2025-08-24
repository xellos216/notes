package ui;

import model.ArithmeticOperator;

import java.util.Scanner;
import java.util.List;


public class CalculatorUI {
    private final Scanner scanner = new Scanner(System.in);

    public void printWelcome() {
        System.out.println("=== Calculator ===");
    }

    public Double readNumber(String prompt) {
        System.out.print(prompt);
        String input = scanner.next();
        if (input.equalsIgnoreCase("exit")) return null;

        try {
            return Double.parseDouble(input);
        } catch (
                NumberFormatException e) {
            System.out.println("Invalid number input");
            return readNumber(prompt);
        }
    }

    public ArithmeticOperator readOperator(String prompt) {
        System.out.print(prompt);
        String symbol = scanner.next();
        try {
            return ArithmeticOperator.fromSymbol(symbol);
        } catch (IllegalArgumentException E) {
            System.out.println("Invalid operator:");
        }
        return null;

    }

    public void printResult(double result) {
        System.out.println(String.format("= %.5f", result));
    }

    public void printHistory(List<Double> results) {
        System.out.println();
        System.out.println("[ History ] ");
        System.out.print("[ ");
        for (int i = 0; i < results.size(); i++) {
            System.out.print(String.format("%.5f", results.get(i)));
            if (i < results.size() - 1) System.out.print(", ");
        }
        System.out.println(" ]");
        System.out.println();
    }

    public void printDebug(service.ArithmeticCalculator calc) {
        System.out.println();
        System.out.println("[ Stats from previous results ]");
        System.out.println("Max result: " + String.format("%.5f", calc.getMaxResult()));
        System.out.println("Min result: " + String.format("%.5f", calc.getMinResult()));
        System.out.println("Sum of all results: " + String.format("%.5f", calc.getSumResult()));
    }

    public void printError(String message) {
        System.out.println("[Error] " + message);

    }

    public void printExit() {
        System.out.println("Exiting calculator...");
    }
}
