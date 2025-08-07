## 🧠 Problem
“명예의 전당”이라는 TV 프로그램에서는 매일 1명의 가수가 노래를 부르고, 
시청자 문자 투표 점수를 받습니다. 

- **Hall of Fame** 에는 프로그램 시작 이후부터 현재까지의 점수 중 **상위 `k`개**가 올라갑니다. 
- 다만 초기 `k`일 동안은 누적 가수 수가 `k`보다 작으므로, **지금까지의 모든 점수**가 등록됩니다. 
- 매일 방송 말미에는 **현재 Hall of Fame에서 가장 낮은 점수**를 발표합니다.

`k`와 1일부터 마지막 날까지의 점수 리스트 `score`가 주어질 때, 
매일 발표된 “명예의 전당” 최하위 점수를 순서대로 담아 return 하는 `solution` 함수를 작성하세요.

### Constraints
- 3 ≤ `k` ≤ 100
- 7 ≤ `len(score)` ≤ 1,000
- 0 ≤ `score[i]` ≤ 2,000

### Example
| k | score | result |
|---|---|---|
| 3 | `[10, 100, 20, 150, 1, 100, 200]` | `[10, 10, 10, 20, 20, 100, 100]` |
| 4 | `[0, 300, 40, 300, 20, 70, 150, 50, 500, 1000]` | `[0, 0, 0, 20, 40, 70, 70, 150, 300]` |

---

## 🐍 Python Reference Code

### 1. `heapq`(min‑heap) 사용

```python
import heapq

def solution(k, score):
    hall = []          # min-heap
    answer = []

    for s in score:
        if len(hall) < k:
            heapq.heappush(hall, s)
        else:
            if s > hall[0]:          # 최하위보다 크면 교체
                heapq.heapreplace(hall, s)
        answer.append(hall[0])       # 현재 최하위 점수 기록
    return answer
```

### 2. 정렬 리스트 사용

```python
def solution(k, score):
    hall = []
    answer = []

    for s in score:
        hall.append(s)
        hall.sort(reverse=True)      # 내림차순 정렬
        if len(hall) > k:            # k개 초과 시 잘라냄
            hall = hall[:k]
        answer.append(hall[-1])      # k번째(최하위) 점수 기록
    return answer
```
