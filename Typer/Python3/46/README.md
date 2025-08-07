## 🧠 Problem
숫자 문자열에 일부 숫자가 영어 단어로 바뀌어 있습니다. 이 문자열 `s`를 받아 원래 숫자 문자열로 변환해 정수로 리턴하는 함수를 작성하세요.

### Constraints
- 1 ≤ `s`의 길이 ≤ 50
- `s`는 "zero" 또는 "0"으로 시작하지 않습니다.
- 리턴값은 1 이상 2,000,000,000 이하의 정수입니다.

### Example
- Input: `"one4seveneight"`
- Output: `1478`

- Input: `"23four5six7"`
- Output: `234567`

---

## 🐍 Python Reference Code

```python
def solution(s):
    numbers = {
        "zero": "0", "one": "1", "two": "2", "three": "3", "four": "4",
        "five": "5", "six": "6", "seven": "7", "eight": "8", "nine": "9"
    }

    for word, digit in numbers.items():
        s = s.replace(word, digit)

    return int(s)
```
