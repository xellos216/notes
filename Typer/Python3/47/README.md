## 🧠 Problem
문자열로 이루어진 리스트 `strings`와 정수 `n`이 주어진다.
이때, 각 문자열의 `n`번째 문자를 기준으로 리스트를 정렬하되,
**해당 문자가 같을 경우 전체 문자열을 기준으로 사전순 정렬**한다.

### Constraints
- `strings`는 길이 1 이상 1,000 이하의 리스트
- 각 원소는 길이 1 이상 100 이하의 문자열
- 문자열은 소문자로만 이루어짐
- `n`은 0 이상 문자열 길이 미만의 정수

### Example
- Input: `["sun", "bed", "car"], n = 1`
- Output: `["car", "bed", "sun"]`
  (1번째 문자 기준 정렬: `"u", "e", "a"` → `"a" < "e" < "u"`)

- Input: `["abce", "abcd", "cdx"], n = 2`
- Output: `["abcd", "abce", "cdx"]`

---

## 🐍 Python Reference Code

```python
def solution(strings, n):
    return sorted(strings, key=lambda x: (x[n], x))
```
