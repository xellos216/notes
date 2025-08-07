## 🧠 Problem
정수 배열 `arr`에서 **제일 작은 수 하나만 제거**한 배열을 리턴하는 함수를 작성하시오.  
단, 배열이 비게 되는 경우에는 `[-1]`을 리턴해야 한다.

### Constraints
- `arr`는 길이 1 이상의 리스트입니다.
- `arr`의 원소는 0 이상 1,000,000 이하의 정수
- 원소들은 중복될 수 있지만, **제일 작은 수 하나만** 제거해야 함

### Example
- Input: `[4, 3, 2, 1]`  
- Output: `[4, 3, 2]`  
  (제일 작은 수 1 제거)

- Input: `[10]`  
- Output: `[-1]`  
  (제거하면 빈 배열이 되므로 -1 반환)

---

## 🐍 Python Reference Code

```python
def solution(arr):
    if len(arr) == 1:
        return [-1]
    arr.remove(min(arr))
    return arr
```
