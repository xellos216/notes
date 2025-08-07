## 🧠 Problem
코니는 영어 단어가 적힌 카드 뭉치 두 개를 선물 받았습니다.
각 카드 뭉치는 **순서를 유지한 채**, 한 장씩만 사용할 수 있습니다.

목표는 이 카드들을 이용해 `goal` 리스트에 주어진 문장을 **순서대로 만들 수 있는지** 확인하는 것입니다.

### 사용 규칙
- 한 번 사용한 카드는 다시 사용할 수 없음
- 카드의 순서는 바꿀 수 없음
- 건너뛰기도 불가능 (순서대로만 사용 가능)

## 🧾 Input

```python
cards1 = ["i", "drink", "water"]
cards2 = ["want", "to"]
goal   = ["i", "want", "to", "drink", "water"]
```

→ 이 경우 `"Yes"`를 리턴해야 함

```python
cards1 = ["i", "water", "drink"]
cards2 = ["want", "to"]
goal   = ["i", "want", "to", "drink", "water"]
```

→ 이 경우 `"No"`를 리턴해야 함 (순서 불일치)

---

## 🐍 Python Reference Code

### ✅ 방법 1: `deque` 사용

```python
from collections import deque

def solution(cards1, cards2, goal):
    cards1 = deque(cards1)
    cards2 = deque(cards2)

    for word in goal:
        if cards1 and cards1[0] == word:
            cards1.popleft()
        elif cards2 and cards2[0] == word:
            cards2.popleft()
        else:
            return "No"
    return "Yes"
```

---

### ✅ 방법 2: 인덱스(index) 사용 (deque 없이)

```python
def solution(cards1, cards2, goal):
    i, j = 0, 0

    for word in goal:
        if i < len(cards1) and cards1[i] == word:
            i += 1
        elif j < len(cards2) and cards2[j] == word:
            j += 1
        else:
            return "No"
    return "Yes"
```

---

## ✅ Summary

| 방식     | 장점              | 단점             |
|----------|-------------------|------------------|
| `deque` | 직관적, 빠름       | 라이브러리 필요 |
| index   | `deque` 없이 가능 | 인덱스 관리 필요 |
