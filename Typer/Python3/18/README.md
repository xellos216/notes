## 🧠 Problem
자연수 `n`이 주어지면, `n`의 각 자릿수를 더한 값을 반환하는 함수를 작성하시오.

### Constraints
- `n`은 100,000,000 이하의 자연수

### Example
- Input: `n = 123`
- Output: `6`  
  (1 + 2 + 3 = 6)

- Input: `n = 987`
- Output: `24`  
  (9 + 8 + 7 = 24)

---

## 🐍 Python Reference Code

### 1. 문자열 변환
```python
def solution(n):
    return sum(int(d) for d in str(n))
```

### 2. map 사용
```python
def solution(n):
    return sum(map(int, str(n)))
```

### 3. for 사용
```python
def solution(n):
    answer = 0
    for digit in str(n):
        answer += int(digit)
    return answer
```

### 4. while 사용
```python
def solution(n):
    answer = 0
    while n > 0:
        answer += n % 10
        n //= 10
    return answer
```
