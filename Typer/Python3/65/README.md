## 🧠 Problem
문자열 `s`가 주어집니다. 이 문자열을 아래 규칙에 따라 여러 개의 부분 문자열로 나누는 것이 목표입니다:

1. 문자열의 첫 글자를 읽고, 이를 기준 문자 `x`로 설정합니다.
2. 이후 왼쪽부터 오른쪽으로 한 글자씩 읽으며,
   - 문자 `x`가 나온 횟수 (`count_x`)
   - 문자 `x`가 아닌 글자가 나온 횟수 (`count_other`)
   를 각각 셉니다.
3. `count_x`와 `count_other`가 같아지는 순간, 하나의 부분 문자열로 분리됩니다.
4. 나머지 문자열에 대해서도 같은 과정을 반복합니다.
5. 더 이상 문자가 남지 않으면 과정을 종료합니다.

함수 `solution(s)`를 작성하여, **이 과정을 통해 만들어진 부분 문자열의 개수**를 반환하세요.

## Constraints
- `1 ≤ len(s) ≤ 10,000`
- `s`는 오직 소문자 알파벳 (`a`부터 `z`)로만 구성됩니다.

## Example
| 입력 문자열 s      | 결과 |
|------------------|------|
| "banana"         | 3    |
| "abracadabra"    | 6    |
| "aaabbaccceba"   | 3    |

---

## 🐍 Python Reference Code

### 1. 기준 문자와 나머지 문자의 수 비교하여 나누기 (그리디)
```python
def solution(s):
    result = 0
    count_x = 0
    count_other = 0
    x = ''

    for c in s:
        if x == '':
            x = c

        if c == x:
            count_x += 1
        else:
            count_other += 1

        if count_x == count_other:
            result += 1
            x = ''
            count_x = 0
            count_other = 0

    if count_x != 0 or count_other != 0:
        result += 1

    return result
```
