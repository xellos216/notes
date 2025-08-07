```java
import java.math.BigDecimal;

public class SubtractOperation implements Operation {
	@Override
	public <T extends Number> T apply(T a, T b, Class<T> type) {
	    BigDecial sub = convertToBigDecimal(a).subtract(convertToBigDecimal(b));
	    return castToType(sub, type);
	}
    }
```
