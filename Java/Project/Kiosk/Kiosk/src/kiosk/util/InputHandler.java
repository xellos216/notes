package kiosk.util;

import java.util.InputMismatchException;
import java.util.Scanner;

public class InputHandler {
    private static final Scanner scanner = new Scanner(System.in);

    public static int getIntInput(String message) {
        while (true) {
            System.out.print(message);

            try {
                String raw = scanner.nextLine().trim();
                return Integer.parseInt(raw);
            } catch (NumberFormatException | InputMismatchException e) {
                System.out.println("정해진 번호만 입력해주세요.");
                System.out.println();
            }
        }
    }

     public static int getIntInRange(String msg, int min, int max) {
        while (true) {
            int n = getIntInput(msg);
            if (n >= min && n <= max) return n;

            System.out.printf(" %d ~ %d 사이의 숫자만 입력해주세요.%n%n", min, max);
        }
    }

    public static int getIntInRange(String msg, int max) {
        return getIntInRange(msg, 0, max);
    }

    public static String getStringInput(String message) {
        while (true) {
            System.out.print(message);
            String input = scanner.nextLine().trim();

            if (!input.isEmpty()) return input;
            System.out.println("내용을 입력해주세요.");
            System.out.println();

        }
    }

}
