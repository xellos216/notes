## 🧠 Problem
정수 `n`을 입력받아 각 자릿수를 큰 것부터 작은 순으로 정렬한 새로운 정수를 반환 함수를 작성하시오.

### Constraints
- 1 ≤ n ≤ 8,000,000,000

### Example
- Input: `118372`
- Output: `873211`

---

## 🐍 Python Reference Code

```python
def solution(n):
    return int(''.join(sorted(str(n), reverse=True)))
```


