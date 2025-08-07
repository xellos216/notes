## 🧠 Problem
정수 `n`이 주어질 때, `n`의 모든 약수를 더한 값을 반환하는 함수를 작성하시오.

### Constraints
- `n`은 0보다 크고 30,000 이하인 정수

### Example
- Input: `n = 12`
- Output: `28`  
  (1 + 2 + 3 + 4 + 6 + 12)

- Input: `n = 5`
- Output: `6`  
  (1 + 5)

---

## 🐍 Python Reference Code

```python
def solution(n):
    answer = 0
    for i in range(1, n + 1):
        if n % i == 0:
            answer += i
    return answer
```
