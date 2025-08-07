## 🧠 Problem
정수 배열 `numbers`가 주어진다. `numbers`에서 **서로 다른 인덱스**에 있는 두 개의 수를 뽑아 **더한 값을 모두 구한 뒤**, **오름차순으로 정렬된 리스트**를 반환하라.

### Constraints
- `numbers`의 길이는 2 이상 100 이하
- 각 원소는 0 이상 100 이하의 정수

### Example
- Input: `[2,1,3,4,1]`
- Output: `[2,3,4,5,6,7]`

- Input: `[5,0,2,7]`
- Output: `[2,5,7,9,12]`

---

## 🐍 Python Reference Code

### 1. `set` + 중첩 for문 사용 (중복 제거 + 정렬)

```python
def solution(numbers):
    result = set()
    for i in range(len(numbers)):
        for j in range(i+1, len(numbers)):
            result.add(numbers[i] + numbers[j])
    return sorted(result)
```

### 2. 리스트 컴프리헨션 + `set` 사용 (간결함 중심)

```python
def solution(numbers):
    return sorted({numbers[i] + numbers[j] for i in range(len(numbers)) for j in range(i+1, len(numbers))})
```
