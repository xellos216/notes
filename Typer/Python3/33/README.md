## 🧠 Problem
두 정수 `left`, `right`가 주어졌을 때,  
`left`부터 `right`까지의 모든 정수 중 **약수의 개수가 짝수면 더하고, 홀수면 뺀 결과**를 리턴하는 함수를 작성하시오.

### Constraints
- `1 ≤ left ≤ right ≤ 1,000`

### Example
- Input: `left = 13`, `right = 17`  
- Output: `43`  
  (14와 16은 약수의 개수가 짝수 → 더함 / 13, 15, 17은 약수 개수 홀수 → 뺌)

- Input: `left = 24`, `right = 27`  
- Output: `52`

---

## 🐍 Python Reference Code

```python
def solution(left, right):
    answer = 0
    for i in range(left, right + 1):
        if i ** 0.5 == int(i ** 0.5):
            answer -= i
        else:
            answer += i
    return answer
```
