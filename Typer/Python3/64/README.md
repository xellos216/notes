## 🧠 Problem
점심시간에 몇몇 학생들의 체육복이 도난당했습니다. 다행히 일부 학생들은 여벌의 체육복을 가지고 있어서, 다른 학생들에게 빌려줄 수 있습니다. 학생 번호는 연속적으로 매겨져 있으며, 각 학생은 번호가 바로 앞이나 뒤인 학생에게만 체육복을 빌려줄 수 있습니다. 즉, 학생 i는 학생 i − 1 또는 i + 1 에게만 체육복을 빌려줄 수 있습니다.

총 학생 수 n, 체육복을 도난당한 학생들의 번호 목록 lost, 여벌 체육복을 가진 학생들의 번호 목록 reserve가 주어졌을 때,
최적의 방법으로 체육복을 빌려준 후 체육 수업에 참여할 수 있는 최대 학생 수를 구하는 함수를 작성하세요.

- 자신의 체육복을 도난당했지만 여벌이 있는 학생은 체육복이 하나 남기 때문에 다른 학생에게는 빌려줄 수 없습니다.
- 여벌 체육복은 한 번만 빌려줄 수 있습니다.
- 체육복을 빌려줄 수 있는 대상은 바로 앞 번호 또는 바로 뒤 번호의 학생뿐입니다.

## Constraints
- 2 ≤ n ≤ 30
- 1 ≤ len(lost) ≤ n, lost는 중복되지 않는 번호로 구성됨
- 1 ≤ len(reserve) ≤ n, reserve도 중복되지 않는 번호로 구성됨
- 같은 번호가 lost와 reserve 양쪽에 동시에 존재할 수 있음 (자신의 것을 잃고 여벌이 하나 있는 경우)

## Example
| n | lost  | reserve   | return |
|---|-------|-----------|--------|
| 5 | [2,4] | [1,3,5]   | 5 |
| 5 | [2,4] | [3]       | 4 |
| 3 | [3]   | [1]       | 2 |

---

## 🐍 Python Reference Code
### 1. `set` difference + greedy
```python
def solution(n, lost, reserve):
    real_lost    = set(lost)    - set(reserve)   # lost but no spare
    real_reserve = set(reserve) - set(lost)      # spare but not lost

    for r in sorted(real_reserve):               # check neighbours
        if r - 1 in real_lost:
            real_lost.remove(r - 1)
        elif r + 1 in real_lost:
            real_lost.remove(r + 1)

    return n - len(real_lost)
```

### 2. Array‑based sweep
```python
def solution(n, lost, reserve):
    clothes = [1] * (n + 1)          # index 1..n, 1 uniform each
    for i in lost:
        clothes[i] -= 1              # now 0
    for i in reserve:
        clothes[i] += 1              # now 2 if not lost

    for i in range(1, n + 1):
        if clothes[i] == 0:
            if i - 1 >= 1 and clothes[i - 1] == 2:
                clothes[i - 1] -= 1
                clothes[i] += 1
            elif i + 1 <= n and clothes[i + 1] == 2:
                clothes[i + 1] -= 1
                clothes[i] += 1

    return sum(1 for i in range(1, n + 1) if clothes[i] > 0)
```
