## 🧠 Problem
정수들의 절댓값을 담은 리스트 `absolutes`와, 각 정수의 부호를 나타내는 `signs` 리스트가 주어진다.
각 정수에 부호를 적용해 실제 정수로 만들고, 그 총합을 구하여 반환하는 함수를 작성하라.

### Constraints
- `absolutes`의 길이는 1 이상 1,000 이하
- `absolutes`의 각 원소는 1 이상 1,000 이하인 정수
- `signs`의 길이는 `absolutes`와 같음
  - `signs[i]`가 `True`이면 `absolutes[i]`는 양수
  - `signs[i]`가 `False`이면 `absolutes[i]`는 음수

### Example
- Input: `absolutes = [4, 7, 12], signs = [True, False, True]`
- Output: `9`

---

## 🐍 Python Reference Code

```python
def solution(absolutes, signs):
    answer = 0
    for num, sign in zip(absolutes, signs):
        if sign:
            answer += num
        else:
            answer -= num
    return answer
```
