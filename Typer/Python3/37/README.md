## 🧠 Problem
2개의 2차원 정수 배열 `arr1`, `arr2`가 주어졌을 때,  
**같은 위치의 값끼리 더한 결과로 구성된 새로운 2차원 배열**을 리턴하는 함수를 작성하시오.

### Constraints
- 각 배열의 행과 열의 길이는 1 이상 500 이하입니다.

### Example
- Input:
```python
arr1 = [[1, 2], [2, 3]]
arr2 = [[3, 4], [5, 6]]
```
- Output:
```python
[[4, 6], [7, 9]]
```

---

## 🐍 Python Reference Code

```python
def solution(arr1, arr2):
    return [[a + b for a, b in zip(row1, row2)] for row1, row2 in zip(arr1, arr2)]
```

## for문 사용

```python
def solution(arr1, arr2):
    result = []
    for row1, row2 in zip(arr1, arr2):
        temp = []
        for a, b in zip(row1, row2):
            temp.append(a + b)
        result.append(temp)
    return result
```
