## 🧠 Problem
길이가 n이고, "수박수박수박수..."와 같은 패턴을 유지하는 문자열을 반환하는 함수를 작성하세요.

예를 들어 `n`이 4이면 "수박수박"을 반환하고, `n`이 3이라면 "수박수"를 반환하면 됩니다.

---

### Constraints
- `n`은 길이 10,000 이하인 자연수입니다.

---

### Example

- Input: `n = 3`  
  Output: `"수박수"`

- Input: `n = 4`  
  Output: `"수박수박"`

---

## 🐍 Python Reference Code
```python
def solution(n):
    return ("수박" * n)[:n]
```
