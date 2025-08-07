## 🧠 Problem
정수 `num1`과 `num2`가 주어질 때, 두 수가 같으면 `1`, 다르면 `-1`을 return하는 함수를 작성하시오.

### Constraints
- 0 ≤ `num1`, `num2` ≤ 10,000

### Example
- Input: `num1 = 2`, `num2 = 3`
- Output: `-1`

- Input: `num1 = 11`, `num2 = 11`
- Output: `1`

---

## 🐍 Python Reference Code

```python
def solution(num1, num2):
    if num1 == num2:
        return 1
    else:
        return -1
```
