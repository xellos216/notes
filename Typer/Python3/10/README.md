## 🧠 Problem
정수 배열 `numbers`가 주어질 때, `numbers`의 평균값을 return하는 함수를 작성하시오.

### Constraints
- 0 ≤ `numbers`의 원소 ≤ 1,000
- 1 ≤ `numbers`의 길이 ≤ 100
- 평균값의 소수 부분은 `.0` 또는 `.5`인 경우만 입력으로 주어집니다.

### Example
- Input: `numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`
- Output: `5.5`

- Input: `numbers = [89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99]`
- Output: `94.0`

---

## 🐍 Python Reference Code

```python
def solution(numbers):
    return sum(numbers) / len(numbers)
```
