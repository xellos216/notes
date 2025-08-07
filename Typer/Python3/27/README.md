## 🧠 Problem
고객 개인정보 보호를 위해, 문자열로 된 전화번호 `phone_number`가 주어졌을 때  
**뒤에서 4자리를 제외한 나머지는 `*`로 가려서** 리턴하는 함수를 작성하시오.

### Constraints
- `phone_number`는 길이 4 이상, 20 이하인 문자열입니다.

### Example
- Input: `"01033334444"`
- Output: `"*******4444"`

- Input: `"027778888"`
- Output: `"*****8888"`

---

## 🐍 Python Reference Code

```python
def solution(phone_number):
    return '*' * (len(phone_number) - 4) + phone_number[-4:]
```
