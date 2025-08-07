## 🧠 Problem
임의의 양의 정수 `n`에 대해, `n`이 어떤 양의 정수 `x`의 제곱인지 판단하려 합니다.

- `n`이 `x`의 제곱이라면 `(x + 1)`의 제곱을 반환하고,
- 제곱이 아니라면 `-1`을 반환하는 함수를 작성하세요.

### Constraints
- `n`은 1 이상, 50,000,000,000 이하의 양의 정수입니다.

### Example

- Input: `121`
  Output: `144`

- Input: `3`
  Output: `-1`

---

## 🐍 Python Reference Code
### 1. 수학적 제곱근 활용
```python
def solution(n):
    x = n ** 0.5
    if x.is_integer():
        return int((x + 1) ** 2)
    else:
        return -1
```

### 2. math 라이브러리 사용
```python
import math

def solution(n):
    sqrt = math.isqrt(n)
    if sqrt * sqrt == n:
        return (sqrt + 1) ** 2
    return -1
```

### 3. while 사용
```python
def solution(n):
    x = 1
    while x * x = n:
        if x * x == n:
            return (x + 1) ** 2
        x += 1
    return -1
```
