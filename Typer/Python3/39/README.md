## 🧠 Problem
두 수 `n`, `m`이 주어질 때,  
- **최대공약수(GCD)** 와  
- **최소공배수(LCM)** 를 차례로 리스트에 담아 리턴하는 함수를 작성하시오.

### Constraints
- 1 ≤ n, m ≤ 10,000,000

### Example
- Input: `n = 3`, `m = 12`
- Output: `[3, 12]`

- Input: `n = 2`, `m = 5`
- Output: `[1, 10]`

---

## 🐍 Python Reference Code

```python
def solution(n, m):
    def gcd(a, b):
        while b:
            a, b = b, a % b
        return a

    g = gcd(n, m)
    l = (n * m) // g
    return [g, l]
```

## 내장함수 버전 (Python ≥ 3.9)
```python
import math

def solution(n, m):
    g = math.gcd(n, m)
    l = math.lcm(n, m)
    return [g, l]


