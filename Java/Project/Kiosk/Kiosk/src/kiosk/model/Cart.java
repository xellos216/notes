package kiosk.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Iterator;

public class Cart {

    private final List<CartItem> items = new ArrayList<>();

    private CartItem findByNameAndTemp(String name, String temp) {
        for (CartItem ci : items) {
            boolean sameName = ci.getMenu().getName().equalsIgnoreCase(name);
            boolean sameTemp = (temp == null)
                    ? ci.getTemperature() == null     // 둘 다 null
                    : temp.equalsIgnoreCase(ci.getTemperature());
            if (sameName && sameTemp) {
                return ci;
            }
        }
        return null;
    }

    public void addItem(CartItem newItem) {
        boolean merged = false;

        for (CartItem ci : items) {
            boolean sameName = ci.getMenu().getName()
                    .equalsIgnoreCase(newItem.getMenu().getName());
            boolean sameTemp = Objects.equals(ci.getTemperature(),
                    newItem.getTemperature());

            if (sameName && sameTemp) {
                ci.increaseQuantity(newItem.getQuantity());
                merged = true;
                break;
            }
        }

        if (!merged) {
            items.add(newItem);
        }
    }

    public int removeOrDecrease(String menuName, String temp, int qty) {
        Iterator<CartItem> it = items.iterator();
        while (it.hasNext()) {
            CartItem ci = it.next();
            boolean same = ci.getMenu().getName().equalsIgnoreCase(menuName)
                    && java.util.Objects.equals(ci.getTemperature(), temp);
            if (!same) continue;

            int removed = (qty == 0 || qty >= ci.getQuantity())
                    ? ci.getQuantity()
                    : qty;

            if (removed == ci.getQuantity()) {
                it.remove();
            } else {
                ci.decreaseQuantity(removed);
            }
            return removed;
        }
        return 0;
    }

    public int calculateTotal() {
        int total = 0;
        for (CartItem item : items) {
            total += item.getTotalPrice();
        }
        return total;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public void clear() {
        items.clear();
    }

    public List<CartItem> getItems() {
        return items;
    }

}


