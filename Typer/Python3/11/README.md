## 🧠 Problem
정수 `num`이 주어질 때, 짝수이면 `"Even"`, 홀수이면 `"Odd"`를 반환하는 함수를 작성하시오.

### Constraints
- `num`은 정수형이며 0은 짝수입니다.

### Example
- Input: `num = 3`
- Output: `"Odd"`

- Input: `num = 4`
- Output: `"Even"`

---

## 🐍 Python Reference Code

```python
def solution(num):
    if num % 2 == 0:
        return "Even"
    else:
        return "Odd"
```
