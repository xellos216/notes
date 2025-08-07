package kiosk.model;

public enum UserType {
    CAT(0.01),
    DOG(0.02),
    IDIOT(0.03);

    private final double discountRate;

    UserType(double discountRate) {
        this.discountRate = discountRate;
    }

    public double getDiscountRate() {
        return discountRate;
    }


    public static UserType fromInt(int input) {
        return switch (input) {
            case 1 -> CAT;
            case 2 -> DOG;
            case 3 -> IDIOT;
            default -> throw new IllegalArgumentException("잘못된 할인 유형입니다.");
        };
    }

    @Override
    public String toString() {
        return switch (this) {
            case CAT -> "고양이";
            case DOG -> "강아지";
            case IDIOT -> "머저리";
        };
    }


}
