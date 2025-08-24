package util;

import java.util.Optional;
import java.util.function.Supplier;

public class SafeRunner {
    private static String safeGet(Supplier<Optional<Double>> supplier) {
        try {
            return supplier.get()
                    .map(Object::toString)
                    .orElse("N/A");
        } catch (Exception e) {
            return "Error";
        }
    }

    // 예외 방지를 위한 래퍼 함수형 인터페이스
    private static String safeGet(SupplierWithException<Double> supplier) {
        try {
            return String.valueOf(supplier.get());
        } catch (Exception E) {
            return "Invalid input";
        }
    }

    @FunctionalInterface
    interface SupplierWithException<T> {
        T get() throws Exception;
    }
}
