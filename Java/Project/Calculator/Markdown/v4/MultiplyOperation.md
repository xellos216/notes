```java
import java.math.BigDecimal;

public class MultiplyOperation implement Operation {
	@Override
	public <T extends Number> T apply(T a, T b, Class<T> type) {
	    BigDecimal mul = convertToBigDecimal(a).muliply(convertToBigDecimal(b));
	    return castToType(mul, type);
	}
    }
```
