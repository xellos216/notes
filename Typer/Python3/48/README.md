## 🧠 Problem
배열 `array`의 i번째 숫자부터 j번째 숫자까지 자르고 정렬했을 때,
**k번째에 있는 수를 구하는 함수**를 작성하시오.

### Constraints
- `array`의 길이는 1 이상 100 이하
- 각 원소는 1 이상 100 이하의 정수
- `commands`의 길이는 1 이상 50 이하
- `commands[i]`는 `[i, j, k]` 형태의 정수 배열

### Example
- Input:
  ```python
  array = [1, 5, 2, 6, 3, 7, 4]
  commands = [[2, 5, 3], [4, 4, 1], [1, 7, 3]]
  ```
- Output: `[5, 6, 3]`

---

## 🐍 Python Reference Code

### 1. 리스트 컴프리헨션 사용

```python
def solution(array, commands):
    return [sorted(array[i-1:j])[k-1] for i, j, k in commands]
```

### 2. for문 사용

```python
def solution(array, commands):
    result = []  # 결과를 담을 리스트

    for command in commands:
        i, j, k = command            
        sliced = array[i-1:j]          # i번째부터 j번째까지 자르기
        sliced.sort()                  # 정렬
        result.append(sliced[k-1])     # k번째 수 추출하여 추가

    return result
```
