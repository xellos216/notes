## 🧠 Problem
길이가 n인 문자열을 만들되, `"수박수박수박..."` 패턴을 유지하며 앞에서부터 n글자만 리턴하는 함수를 작성하시오.

### Constraints
- `n`은 1 이상 10,000 이하인 자연수입니다.

### Example
- Input: `n = 3`  
- Output: `"수박수"`

- Input: `n = 4`  
- Output: `"수박수박"`

---

## 🐍 Python Reference Code

```python
def solution(n):
    return ("수박" * n)[:n]
```
