package kiosk.ui;

import kiosk.model.*;

import java.util.List;

public final class ConsolePrinter {
    private ConsolePrinter() {
    }

    private static final String RESET = "\u001B[0m";
    private static final String BOLD  = "\u001B[1m";

    public static String money(int won) {
        return String.format("%,d원", won);
    }

    public static void showCategories(boolean hasCart) {
        System.out.println("[ Category ]");
        System.out.println("1. Coffees");
        System.out.println("2. Non-Coffees");
        System.out.println("3. Desserts");

        if (hasCart) {
            System.out.println();
            System.out.println("[ Order ]");
            System.out.println("4. Place Order");
            System.out.println("5. Cancel");
        }

        System.out.println("0. 종료");
        System.out.println();
    }

    public static void showMenu(List<Menu> menus, Category cat) {
        System.out.println("[" + cat + " Menu]");

        for (int i = 0; i < menus.size(); i++) {
            Menu m = menus.get(i);
            System.out.println((i + 1) + ". " + m);
        }
        System.out.println("0. 이전");
    }

    public static void addedToCart(String name, int qty, String temp) {
        if (temp == null) {
            System.out.printf("%s %d개를 장바구니에 담았습니다.%n%n", name, qty);
        } else {
            System.out.printf("%s(%s) %d개를 장바구니에 담았습니다.%n%n",
                    name, temp, qty);
        }
    }

    public static void cartCleared() {
        System.out.println("[장바구니를 비웠습니다.]\n");
    }

    public static void showCart(Cart cart) {
        if (cart.isEmpty()) {
            System.out.println("[ 장바구니가 비어 있습니다.]\n");
            return;
        }

        System.out.println(BOLD + "[ 현재 장바구니 ]" + RESET);
        int total = 0;
        for (CartItem ci : cart.getItems()) {
            System.out.printf("%s × %d = %,d원%n",
                    ci, ci.getQuantity(), ci.getTotalPrice());
            total += ci.getTotalPrice();
        }
        System.out.printf("총 결제 금액: %,d원%n%n", total);
    }

    public static void askDiscountMenu() {
        System.out.println("할인 유형을 선택하세요.");
        System.out.println("1. 고양이 - 1%");
        System.out.println("2. 강아지 - 2%");
        System.out.println("3. 머저리 - 3%");
    }

    public static void checkoutSummary(int total, UserType type, int finalTotal) {
        System.out.println("[ 결제 내역 요약 ]");
        System.out.println("총 금액 : " + money(total));
        System.out.println("할인 유형 : " + type);
        System.out.println("적용 할인율 : " + (int) (type.getDiscountRate() * 100) + "%");
        System.out.println("할인 적용 금액 : " + money(finalTotal));
        System.out.println("결제가 완료되었습니다.\n");
    }

    public static void info(String msg) {
        System.out.println(msg);
    }
}