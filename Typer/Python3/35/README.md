## 🧠 Problem
놀이기구의 이용 요금이 `price`원이고,  
이용할 때마다 요금이 `price`, `2*price`, `3*price`, ..., `count*price`로 증가한다고 할 때,  
현재 가진 돈 `money`로는 **얼마가 부족한지** 계산하여 리턴하는 함수를 작성하시오.

단, **돈이 부족하지 않으면 0을 리턴**합니다.

### Constraints
- 1 ≤ price ≤ 2,500
- 1 ≤ money ≤ 1,000,000,000
- 1 ≤ count ≤ 2,500

### Example
- Input: `price = 3`, `money = 20`, `count = 4`
- Output: `10`  
  → 총 필요한 금액 = 3 + 6 + 9 + 12 = 30 → 30 - 20 = 10

---

## 🐍 Python Reference Code

```python
def solution(price, money, count):
    total = price * (count * (count + 1) // 2)
    return max(0, total - money)
```
