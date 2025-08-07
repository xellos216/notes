## 🧠 Problem
머쓱이는 태어난 지 11개월 된 조카를 돌보고 있습니다.
조카는 아직 `"aya"`, `"ye"`, `"woo"`, `"ma"` 네 가지 발음과 
네 가지 발음을 조합해서 만들 수 있는 발음 외에는 하지 못하고,
같은 발음을 연속해서 말할 수 없습니다.

문자열 배열 `babbling`이 주어질 때, 머쓱이의 조카가 발음할 수 있는 단어의 개수를 return 하는
`solution` 함수를 작성하세요.

---

### Constraints
- 1 ≤ `babbling`의 길이 ≤ 100
- 1 ≤ `babbling[i]`의 길이 ≤ 30
- 문자열은 알파벳 소문자로만 구성됨

---

### Example

- Input:
```python
babbling = ["aya", "yee", "u", "maa"]
```
- Output: `1`

- Input:
```python
babbling = ["ayaye", "uuu", "yeye", "yemawoo", "ayaayaa"]
```
- Output: `2`

---

## 🐍 Python Reference Code
```python
def solution(babbling):
    possible = ["aya", "ye", "woo", "ma"]
    count = 0

    for word in babbling:
        for p in possible:
            if p * 2 in word:
                break
        else:
            for p in possible:
                word = word.replace(p, " ")
            if word.strip() == "":
                count += 1
    return count
```
