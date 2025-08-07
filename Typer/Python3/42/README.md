## 🧠 Problem
정수 리스트 `number`가 주어질 때,  
이 중 **서로 다른 3명의 학생을 골라 정수 번호를 더한 값이 0이 되는 경우의 수**를 리턴하는 함수를 작성하시오.

### Constraints
- 3 ≤ number의 길이 ≤ 13
- 각 요소는 -1000 이상 1000 이하의 정수
- 정수는 중복될 수 있음

### Example
- Input: `[-2, 3, 0, 2, -5]`  
- Output: `2`  
  → 가능한 조합: `(-2, 0, 2)`와 `(-5, 3, 2)`

- Input: `[-1, 1, -1, 1]`  
- Output: `0`

---

## 🐍 Python Reference Code

```python
from itertools import combinations

def solution(number):
    count = 0
    for comb in combinations(number, 3):
        if sum(comb) == 0:
            count += 1
    return count
```
