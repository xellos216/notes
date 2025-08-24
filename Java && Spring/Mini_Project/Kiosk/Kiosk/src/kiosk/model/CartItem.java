package kiosk.model;

public class CartItem {
    private Menu menu;
    private int quantity;
    private String temperature;

    public CartItem(Menu menu, int quantity) {
        this(menu, quantity, null);
    }

    public CartItem(Menu menu, int quantity, String temperature) {
        this.menu = menu;
        this.quantity = quantity;
        this.temperature = temperature;
    }

    public Menu getMenu() {
        return menu;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getTemperature() {
        return temperature;
    }

    public int getTotalPrice() {
        return menu.getPrice() * quantity;
    }

    public void increaseQuantity(int qty) {
        this.quantity += qty;
    }

    public void decreaseQuantity(int amount) {
        if (amount <= 0) return;
        quantity = Math.max(0, quantity - amount);
    }

    @Override
    public String toString() {
        if (temperature == null) {
            return menu.getName();
        }
        return String.format("%s (%s)", menu.getName(), temperature);
    }
}