```java

import java.math.BigDecimal;

public class AddOperation implements Operation {
    @Override
    public <T extends Number> T apply(T a, T b, Class<T> type) {
	BigDecimal sum = convertToBigDecimal(a).add(converToBigDecimal(b));
	return castToType(sum, type);
    }
}
```

