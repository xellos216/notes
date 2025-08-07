## 🧠 Problem
문자열 `s`가 주어졌을 때, `s`의 각 위치마다 자신보다 앞에 나왔으며,  
자신과 가장 가까운 곳에 있는 같은 글자가 어디 있는지 알고 싶습니다.

- 같은 글자가 없다면 `-1`을, 있다면 **가장 가까운 거리**를 기록합니다.
- 최종 결과는 정수 리스트로 반환합니다.

### Constraints
- 1 ≤ `s`의 길이 ≤ 10,000
- `s`는 소문자로만 구성됩니다.

### Example
- Input: `"banana"`
- Output: `[-1, -1, -1, 2, 2, 2]`

- Input: `"foobar"`
- Output: `[-1, -1, 1, -1, -1, -1]`

---

## 🐍 Python Reference Code

### ✅ for문 + 딕셔너리 사용

```python
def solution(s):
    answer = []
    last_seen = {}

    for i, char in enumerate(s):
        if char in last_seen:
            answer.append(i - last_seen[char])
        else:
            answer.append(-1)
        last_seen[char] = i

    return answer
```
