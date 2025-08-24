package kiosk.model;

public enum Category {
    COFFEES,
    NON_COFFEES,
    DESSERTS;

    @Override
    public String toString() {
        return switch (this) {
            case COFFEES -> "Coffees";
            case NON_COFFEES -> "Non-Coffees";
            case DESSERTS -> "Desserts";
        };
    }
}
