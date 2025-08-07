## 🧠 Problem
정수 배열 `arr`이 주어질 때, 배열의 평균값을 반환하는 함수를 작성하시오.

### Constraints
- `arr`의 길이는 1 이상 100 이하
- 각 원소는 -10,000 이상 10,000 이하의 정수

### Example
- Input: `arr = [1, 2, 3, 4]`
- Output: `2.5`

- Input: `arr = [5, 5]`
- Output: `5`

---

## 🐍 Python Reference Code

```python
def solution(arr):
    return sum(arr) / len(arr)
```
