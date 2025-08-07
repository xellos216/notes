## 🧠 Problem
2022년 기준으로 선생님의 나이(`age`)가 주어질 때, 선생님의 출생 연도를 구하는 함수를 작성하시오.

- 나이는 태어난 연도에 1살이며, 매년 1월 1일 기준으로 1살씩 증가합니다.

### Constraints
- 0 < `age` ≤ 120

### Example
- Input: `age = 40`
- Output: `1983`

- Input: `age = 23`
- Output: `2000`

---

## 🐍 Python Reference Code

```python
def solution(age):
    return 2022 - (age - 1)
```
