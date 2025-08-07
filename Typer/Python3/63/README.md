## 🧠 Problem
두 정수 `X`, `Y`의 임의의 자리에서 공통으로 나타나는 정수 k (0 ≤ k ≤ 9) 들을 이용하여 만들 수 있는 가장 큰 정수를 수의 짝꿍이라 합니다. (공통으로 나타나는 정수 중 서로 짝지을 수 있는 숫자만 사용합니다.)

- `X`, `Y`의 짝꿍이 존재하지 않으면 짝꿍은 `-1`입니다.
- `X`, `Y`의 짝꿍이 0으로만 구성되어 있다면 짝꿍은 `0`입니다.

## Constraints
- `3 ≤ X, Y`의 길이 ≤ `3,000,000`
- `X`, `Y`는 0으로 시작하지 않음
- `X`, `Y`의 짝꿍은 상당히 큰 수가 될 수 있으므로 문자열로 반환해야 함

## Example
| X       | Y       | result |
|---------|---------|--------|
| "100"   | "2345"  | "-1"   |
| "100"   | "203045"| "0"    |
| "100"   | "123450"| "0"    |
| "12321" | "42531" | "321"  |
| "5525"  | "1255"  | "552"  |

---

## 🐍 Python Reference Code
### 1. 배열 카운트 기반
```python
def solution(X, Y):
    x_count = [0] * 10
    y_count = [0] * 10

    for ch in X:
        x_count[int(ch)] += 1
    for ch in Y:
        y_count[int(ch)] += 1

    result = ""
    for i in range(9, -1, -1):
        count = min(x_count[i], y_count[i])
        result += str(i) * count

    if result == "":
        return "-1"
    elif result[0] == "0":
        return "0"
    else:
        return result
```

### 2. collections.Counter 활용
```python
from collections import Counter

def solution(X, Y):
    x_count = Counter(X)
    y_count = Counter(Y)

    result = []
    for digit in map(str, range(9, -1, -1)):
        pair_count = min(x_count[digit], y_count[digit])
        result.append(digit * pair_count)

    answer = ''.join(result)
    if not answer:
        return "-1"
    if answer[0] == "0":
        return "0"
    return answer
```
