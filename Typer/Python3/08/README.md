## 🧠 Problem
각도 `angle`이 주어질 때, 다음 기준에 따라 분류한 값을 return하는 함수를 작성하시오.

- 예각: 0 < angle < 90 → return 1
- 직각: angle == 90 → return 2
- 둔각: 90 < angle < 180 → return 3
- 평각: angle == 180 → return 4

### Constraints
- 0 < angle ≤ 180
- `angle`은 정수

### Example
- Input: `angle = 70`
- Output: `1`

- Input: `angle = 91`
- Output: `3`

- Input: `angle = 180`
- Output: `4`

---

## 🐍 Python Reference Code

```python
def solution(angle):
    if 0 < angle < 90:
        return 1
    elif angle == 90:
        return 2
    elif 90 < angle < 180:
        return 3
    elif angle == 180:
        return 4
```
