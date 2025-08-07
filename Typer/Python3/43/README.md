## 🧠 Problem
문자열 `t`에서 길이가 `p`와 같은 **부분 문자열**들 중,  
10진수로 해석했을 때 `p`보다 작거나 같은 숫자의 개수를 구하시오.

### Constraints
- 1 ≤ p의 길이 ≤ 18
- p의 길이 ≤ t의 길이 ≤ 10,000
- `t`와 `p`는 숫자로만 구성된 문자열
- `t`와 `p`는 0으로 시작하지 않음

### Example
- Input: `t = "3141592", p = "271"`  
- 부분 문자열들: `"314", "141", "415", "159", "592"`  
- 이 중 `"141", "159"`는 271보다 작거나 같음 → 결과: `2`

---

## 🐍 Python Reference Code

```python
def solution(t, p):
    answer = 0
    p_len = len(p)

    for i in range(len(t) - p_len + 1):
        sub = t[i:i + p_len]
        if int(sub) <= int(p):
            answer += 1

    return answer
```
