## 🧠 Problem
정수 `num1`과 `num2`가 주어질 때, `num1`을 `num2`로 나눈 값에 1,000을 곱한 뒤,  
그 정수 부분만 반환하는 함수를 작성하시오.

### Constraints
- 0 < `num1`, `num2` ≤ 100

### Example
- Input: `num1 = 3`, `num2 = 2`
- Output: `1500`

- Input: `num1 = 7`, `num2 = 3`
- Output: `2333`

- Input: `num1 = 1`, `num2 = 16`
- Output: `62`

---

## 🐍 Python Reference Code

```python
def solution(num1, num2):
    return int(num1 / num2 * 1000)
```
