## 🧠 Problem
두 정수 `n`과 `m`이 입력되었을 때,  
별(`*`) 문자를 사용하여 **가로 길이 n, 세로 길이 m인 직사각형**을 출력하는 프로그램을 작성하시오.

- 첫 번째 줄에 공백으로 구분된 두 자연수 `n`과 `m`이 주어짐
- `n`은 가로(열), `m`은 세로(행)의 길이를 의미함

### Constraints
- 1 ≤ n, m ≤ 1,000

### Example
**Input:**
```
5 3
```

**Output:**
```
*****
*****
*****
```

---

## 🐍 Python Reference Code

```python
a, b = map(int, input().split())
for _ in range(b):
    print('*' * a)
```
