package kiosk;

import kiosk.util.InputHandler;
import kiosk.model.Menu;
import kiosk.model.Category;
import kiosk.model.CartItem;
import kiosk.service.KioskService;
import kiosk.ui.ConsolePrinter;

import java.util.List;
import java.util.Set;

public class Main {
    public static void main(String[] args) {
        KioskService kiosk = new KioskService();
        kiosk.initializeMenu();

        System.out.println("덤탱이 카페에 오신 걸 환영합니다!");
        System.out.println();

        while (true) {
            kiosk.showCategories();
            int categoryChoice = InputHandler.getIntInput("카테고리 번호를 선택하세요: ");
            System.out.println();

            switch (categoryChoice) {
                case 1 -> handleMenu(Category.COFFEES, kiosk);
                case 2 -> handleMenu(Category.NON_COFFEES, kiosk);
                case 3 -> handleMenu(Category.DESSERTS, kiosk);

                case 4 -> {
                    if (!kiosk.isCartEmpty()) {
                        kiosk.showCart();
                        System.out.println("1. 결제하기  2. 메뉴 제거  3. 이전으로");
                        int confirm = InputHandler.getIntInRange("선택: ", 1, 3);
                        System.out.println();

                        switch (confirm) {

                            case 1 -> kiosk.checkout();
                            case 2 -> {
                                String name = InputHandler.getStringInput("제거할 메뉴 이름: ");

                                List<CartItem> matches = kiosk.getItemsByName(name);
                                if (matches.isEmpty()) {
                                    ConsolePrinter.info("장바구니에 해당 메뉴가 없습니다.\n");
                                    break;
                                }

                                CartItem target;
                                if (matches.size() == 1) {
                                    target = matches.get(0);
                                } else {
                                    System.out.println("제거할 메뉴를 선택하세요:");
                                    for (int i = 0; i < matches.size(); i++) {
                                        CartItem ci = matches.get(i);
                                        System.out.printf("%d. %s (%s) × %d%n",
                                                i + 1, ci.getMenu().getName(),
                                                ci.getTemperature(), ci.getQuantity());
                                    }
                                    int opt = InputHandler.getIntInRange("번호: ", 1, matches.size());
                                    target = matches.get(opt - 1);
                                }

                                int qty = InputHandler.getIntInRange("몇 개를 제거하시겠습니까? ", 0, target.getQuantity());

                                kiosk.removeItem(name, target.getTemperature(), qty);

                                if (!kiosk.isCartEmpty()) {
                                    kiosk.showCart();
                                }
                            }
                            case 3 -> System.out.println("메인 선택창으로 돌아갑니다.\n");
                            default -> System.out.println("올바른 번호를 입력하세요.\n");
                        }
                    }
                }

                case 5 -> {
                    if (!kiosk.isCartEmpty()) {
                        kiosk.clearCart();
                    }
                }

                case 0 -> {
                    System.out.println("이용해주셔서 감사합니다. 프로그램을 종료합니다.");
                    System.exit(0);
                }

                default -> System.out.println("올바른 번호를 입력하세요.\n");
            }
        }
    }

    private static void handleMenu(Category category, KioskService kiosk) {
        kiosk.showMenuByCategory(category);
        System.out.println();
        int menuIndex = InputHandler.getIntInput("메뉴 번호를 선택해주세요: ");
        if (menuIndex == 0) return;

        List<Menu> menus = kiosk.getMenuList().stream()
                .filter(m -> m.getCategory().equals(category))
                .toList();

        if (menuIndex < 1 || menuIndex > menus.size()) {
            System.out.println("잘못된 메뉴 번호입니다.");
            return;
        }

        Menu selected = menus.get(menuIndex - 1);
        String temp = null;

        Set<String> noTempItems = Set.of("에스프레소", "아이스티", "홍차");
        if ((category == Category.COFFEES || category == Category.NON_COFFEES)
                && !noTempItems.contains(selected.getName())) {

            while (true) {
                String input = InputHandler.getStringInput("1. ICE  2. HOT : ").trim();
                if (input.equals("1")) {
                    temp = "ICE";
                    break;
                } else if (input.equals("2")) {
                    temp = "HOT";
                    break;
                } else {
                    System.out.println("1 또는 2만 입력 가능합니다.\n");
                }
            }
        }

        int quantity = InputHandler.getIntInput("수량을 입력하세요: ");

        System.out.println();
        if (temp != null) {
            System.out.println(selected.getName() + "(" + temp + ") " + quantity + "개를 장바구니에 추가하시겠습니까?");
        } else {
            System.out.println(selected.getName() + " " + quantity + "개를 장바구니에 추가하시겠습니까?");
        }
        System.out.println("1. 확인  2. 취소");

        int confirm = InputHandler.getIntInput("선택: ");
        System.out.println();

        if (confirm == 1) {
            if (temp != null) {
                kiosk.addToCart(selected, quantity, temp);
            } else {
                kiosk.addToCart(selected, quantity);
            }
        } else {
            System.out.println("선택한 메뉴가 취소되었습니다.\n");
        }
    }
}
