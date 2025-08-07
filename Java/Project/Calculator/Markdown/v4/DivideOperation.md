```java
import java.math.BigDecimal;

public class DivideOperation implements Operation {
	@Override
	public <T extends Number> T apply(T a, T b, Class<T> type) {
	    BigDecimal divisor = converToBigDecimal(b);
	    if (BigDecimal.ZERO.compareTo(divisor) == 0 {
		throw new IllegalArgumentException("0으로 나눌 수 없습니다.");
	    }
	    BigDecimal div = convertToBigDecimal(a).divide(divisor);
	    return castToType(div, type);
	}
    }
```
