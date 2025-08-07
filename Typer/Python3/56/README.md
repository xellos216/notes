## 🧠 Problem
과일 장수가 사과 상자를 팔아 최대 이익을 내려 합니다.  
사과는 1점부터 `k`점까지의 점수로 분류되며, **`k점이 가장 좋은 사과`**입니다.  

- 한 상자에는 사과를 `m`개 담습니다.
- 상자 하나의 가격 = (그 상자 안 사과 중 **가장 낮은 점수**) × `m`
- 사과는 정렬하거나 버릴 수 있지만, 반드시 `m`개 단위로만 판매합니다.

사과 점수들이 담긴 리스트 `score`가 주어질 때,  
판매 가능한 **최대 이익**을 계산하는 함수를 작성하세요.

### Constraints

- 3 ≤ `k` ≤ 9
- 3 ≤ `m` ≤ 10
- 7 ≤ `len(score)` ≤ 1,000,000
- 1 ≤ `score[i]` ≤ `k`
- 이익이 발생하지 않으면 0을 return

### Example

```python
k = 3
m = 4
score = [1, 2, 3, 1, 2, 3, 1]
# 정답: 8
```

```python
k = 4
m = 3
score = [4, 1, 2, 2, 4, 4, 4, 4, 1, 2, 4, 2]
# 정답: 33
```

---

## 🐍 Python Reference Code

```python
def solution(k, m, score):
    score.sort(reverse=True)  # 높은 점수부터 우선 묶기
    profit = 0

    for i in range(m - 1, len(score), m):
        profit += score[i] * m  # 각 묶음의 최솟값 × m
    return profit
```

---

## ✅ 아이디어 요약

- 높은 점수 사과부터 묶어서 상자를 만듦
- 각 상자 내 가장 낮은 점수를 찾아 `최소점 × m`으로 이익 계산
- 남는 사과는 버림

---
