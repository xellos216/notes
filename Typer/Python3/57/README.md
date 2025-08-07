## 🧠 Problem
수포자 삼인방은 각기 다른 규칙으로 답을 찍습니다.  
모의고사 정답 리스트 `answers`가 주어졌을 때,  
**가장 많이 맞힌 사람(들)**의 번호를 오름차순으로 리턴하는 함수를 작성하세요.

---

### 수포자 찍기 패턴

| 수포자 | 패턴 |
|--------|------|
| 1번 | [1, 2, 3, 4, 5]  
| 2번 | [2, 1, 2, 3, 2, 4, 2, 5]  
| 3번 | [3, 3, 1, 1, 2, 2, 4, 4, 5, 5]  

---

### Example

```python
answers = [1, 2, 3, 4, 5]
# return [1]

answers = [1, 3, 2, 4, 2]
# return [1, 2]
```

---

## 🐍 Python Reference Code

### 1. 가장 기본적인 반복문 + if문 방식

```python
def solution(answers):
    pattern1 = [1,2,3,4,5]
    pattern2 = [2,1,2,3,2,4,2,5]
    pattern3 = [3,3,1,1,2,2,4,4,5,5]

    scores = [0, 0, 0]

    for i, ans in enumerate(answers):
        if pattern1[i % len(pattern1)] == ans:
            scores[0] += 1
        if pattern2[i % len(pattern2)] == ans:
            scores[1] += 1
        if pattern3[i % len(pattern3)] == ans:
            scores[2] += 1

    max_score = max(scores)
    return [i + 1 for i, s in enumerate(scores) if s == max_score]
```

---

### 2. 리스트 컴프리헨션 + zip 방식

```python
def solution(answers):
    patterns = [
        [1,2,3,4,5],
        [2,1,2,3,2,4,2,5],
        [3,3,1,1,2,2,4,4,5,5]
    ]

    scores = [
        sum([p[i % len(p)] == a for i, a in enumerate(answers)])
        for p in patterns
    ]

    max_score = max(scores)
    return [i + 1 for i, s in enumerate(scores) if s == max_score]
```



