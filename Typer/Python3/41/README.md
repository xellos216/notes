## 🧠 Problem
문자열 `s`가 주어졌을 때, 다음 규칙에 따라 변환된 문자열을 리턴하시오.

- 문자열은 여러 단어로 구성되며, 공백(`' '`)으로 구분됨
- 각 단어에서
  - **짝수 인덱스** 문자는 대문자로
  - **홀수 인덱스** 문자는 소문자로 변환

### Constraints
- 단어는 하나 이상의 알파벳으로 구성됨
- 문자열은 영어 알파벳과 공백으로만 이루어져 있음
- 공백은 한 개 이상일 수 있음 (예: `"hello  world"`)

### Example

- Input: `"try hello world"`  
- Output: `"TrY HeLLo WoRLd"`

---

## 🐍 Python Reference Code

```python
def solution(s):
    words = s.split(' ')
    result = []

    for word in words:
        transformed = ''
        for i, char in enumerate(word):
            if i % 2 == 0:
                transformed += char.upper()
            else:
                transformed += char.lower()
        result.append(transformed)

    return ' '.join(result)
```
