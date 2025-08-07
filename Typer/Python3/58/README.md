## 🧠 Problem
주어진 숫자들 중 서로 다른 3개를 골라 **더했을 때 소수**가 되는 경우의 수를 구하세요.

---

### Constraints
- `nums`의 길이: 3 이상 50 이하
- 각 원소는 1 이상 1,000 이하의 자연수
- 중복된 숫자는 없음

---

### Example

```python
nums = [1, 2, 3, 4]
# 가능한 조합: [1,2,4] → 1개 → return 1

nums = [1, 2, 7, 6, 4]
# 가능한 조합: [1,2,4], [1,4,6], [2,4,7], [4,6,7] → 4개 → return 4
```

---

## 🐍 Python Reference Code

### ✅ 방법 1: itertools.combinations 사용

```python
from itertools import combinations

def solution(nums):
    count = 0
    for a, b, c in combinations(nums, 3):
        if is_prime(a + b + c):
            count += 1
    return count
```

### ✅ 방법 2: 3중 for문으로 직접 조합 구현

```python
def solution(nums):
    count = 0
    n = len(nums)

    for i in range(n):
        for j in range(i+1, n):
            for k in range(j+1, n):
                total = nums[i] + nums[j] + nums[k]
                if is_prime(total):
                    count += 1
    return count
```

---

## 🔧 소수 판별 함수 (두 방식 공통)

```python
def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            return False
    return True
```

---
