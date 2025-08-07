## 🧠 Problem
문자열 `s`가 다음 조건을 모두 만족하면 `True`, 아니면 `False`를 반환하는 함수를 작성하시오.

1. 문자열의 길이는 4 또는 6
2. 문자열은 **숫자로만** 구성되어야 함

### Constraints
- `s`는 길이 1 이상, 길이 8 이하의 문자열
- 문자열은 숫자 또는 영문자로만 구성되어 있음

### Example
- Input: `"a234"` → Output: `False`  
- Input: `"1234"` → Output: `True`

---

## 🐍 Python Reference Code

```python
def solution(s):
    return (len(s) == 4 or len(s) == 6) and s.isdigit()
```
