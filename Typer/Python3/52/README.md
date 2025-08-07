## 🧠 Problem
상빈이는 빈 병 `n`개를 가지고 있다. 마트에서는 빈 병 `a`개를 가져오면 콜라 `b`병을 준다.  
상빈이는 빈 병을 모아 최대한 많은 콜라를 받고 싶어 한다.  

콜라를 모두 마시면 다시 빈 병이 되므로,  
새로 생긴 병도 다시 마트에 가져가서 반복적으로 교환할 수 있다.

빈 병을 `a`개 가져가면 콜라 `b`병을 주는 규칙일 때,  
초기 빈 병 `n`개로 받을 수 있는 **총 콜라 병 수**를 return하는 `solution` 함수를 작성하시오.

### Constraints
- 1 ≤ `b` < `a` ≤ `n` ≤ 1,000,000
- 항상 int 범위 내에서 정답이 주어짐

### Example
- Input: `a = 2, b = 1, n = 20` → Output: `19`
- Input: `a = 3, b = 1, n = 20` → Output: `9`

---

## 🐍 Python Reference Code

```python
def solution(a, b, n):
    answer = 0
    while n >= a:
        exchanged = (n // a) * b     # 교환 가능한 콜라 수
        answer += exchanged          # 총 콜라 개수 누적
        n = (n % a) + exchanged      # 남은 병 + 새로 생긴 빈 병
    return answer
```
