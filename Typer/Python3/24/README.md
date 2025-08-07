## 🧠 Problem
String형 배열 `seoul`의 element 중 "Kim"의 위치 `x`를 찾아, "김서방은 x에 있다."는 String을 반환하는 함수를 작성하세요.

### Constraints
- `seoul`은 길이 1 이상, 1000 이하인 배열입니다.
- `seoul`의 원소는 길이 1 이상, 20 이하인 문자열입니다.
- `"Kim"`은 반드시 `seoul` 안에 포함되어 있습니다.

### Example
- Input: `["Jane", "Kim"]`
- Output: `"김서방은 1에 있다."`

---

## 🐍 Python Reference Code

```python
def solution(seoul):
    x = seoul.index("Kim")
    return f"김서방은 {x}에 있다."
```
