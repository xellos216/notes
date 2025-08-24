package kiosk.service;

import kiosk.model.Category;
import kiosk.model.Menu;
import kiosk.model.CartItem;
import kiosk.model.Cart;
import kiosk.model.UserType;
import kiosk.util.InputHandler;
import kiosk.ui.ConsolePrinter;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


public class KioskService {
    private List<Menu> menuList = new ArrayList<>();
    private Cart cart = new Cart();

    public List<Menu> getMenuList() {
        return menuList;
    }

    public boolean isCartEmpty() {
        return cart.isEmpty();
    }

    public void initializeMenu() {
        menuList.add(new Menu("에스프레소", 10000, Category.COFFEES));
        menuList.add(new Menu("아메리카노", 15000, Category.COFFEES));
        menuList.add(new Menu("카페라떼", 20000, Category.COFFEES));
        menuList.add(new Menu("바닐라라떼", 20000, Category.COFFEES));
        menuList.add(new Menu("카푸치노", 25000, Category.COFFEES));
        menuList.add(new Menu("홍차", 15000, Category.NON_COFFEES));
        menuList.add(new Menu("아이스티", 20000, Category.NON_COFFEES));
        menuList.add(new Menu("그린티라떼", 25000, Category.NON_COFFEES));
        menuList.add(new Menu("초코라떼", 25000, Category.NON_COFFEES));
        menuList.add(new Menu("치즈케이크", 30000, Category.DESSERTS));
        menuList.add(new Menu("티라미수", 30000, Category.DESSERTS));
        menuList.add(new Menu("초코머핀", 25000, Category.DESSERTS));
        menuList.add(new Menu("블루베리 베이글", 20000, Category.DESSERTS));
    }

    public void showCategories() {
        ConsolePrinter.showCategories(!cart.isEmpty());
    }

    public void showMenuByCategory(Category category) {
        List<Menu> menus = menuList.stream()
                .filter(m -> m.getCategory() == category)
                .toList();
        ConsolePrinter.showMenu(menus, category);
    }

    public void addToCart(Menu menu, int qty) {
        cart.addItem(new CartItem(menu, qty));
        ConsolePrinter.addedToCart(menu.getName(), qty, null);
    }

    public void addToCart(Menu menu, int qty, String temp) {
        cart.addItem(new CartItem(menu, qty, temp));
        ConsolePrinter.addedToCart(menu.getName(), qty, temp);
    }

    public void showCart() {
        ConsolePrinter.showCart(cart);
    }

    public void clearCart() {
        cart.clear();
        ConsolePrinter.cartCleared();
    }

    public void checkout() {
        if (cart.isEmpty()) {
            ConsolePrinter.info("[장바구니가 비어 있습니다.]\n");
            return;
        }

        ConsolePrinter.showCart(cart);

        ConsolePrinter.askDiscountMenu();
        int input = InputHandler.getIntInput("선택: ");

        int total = (int) cart.calculateTotal();
        UserType type = UserType.fromInt(input);
        int finalTotal = (int) (total * (1 - type.getDiscountRate()));

        ConsolePrinter.checkoutSummary(total, type, finalTotal);

        cart.clear();
        ConsolePrinter.cartCleared();
    }

    public void removeItem(String name, String temp, int qty) {
        int removed = cart.removeOrDecrease(name, temp, qty);

        String label = (temp == null) ? name : name + "(" + temp + ")";
        ConsolePrinter.info(String.format("[%s] %d개가 삭제되었습니다.%n",
                label, removed));
    }


    public List<CartItem> getItemsByName(String name) {
        return cart.getItems().stream()
                .filter(ci -> ci.getMenu().getName()
                        .equalsIgnoreCase(name))
                .collect(Collectors.toList());
    }
}
