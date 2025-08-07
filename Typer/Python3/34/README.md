## 🧠 Problem
문자열 `s`에 나타나는 문자를 **내림차순으로 정렬**하여 새로운 문자열로 리턴하시오.  
단, 영문 대소문자가 혼합되어 있으며, **대문자 < 소문자**로 간주하여 정렬된다.

### Constraints
- `s`는 길이 1 이상인 문자열

### Example
- Input: `"Zbcdefg"`
- Output: `"gfedcbZ"`

---

## 🐍 Python Reference Code

```python
def solution(s):
    return ''.join(sorted(s, reverse=True))
```
