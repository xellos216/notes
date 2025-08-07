## 🔹 등차수열의 합
- 1 + 2 + ... + n = n(n+1)/2
- 예: count = 4 → 1+2+3+4 = 10

## 🔹 전체 필요한 금액
- `price * (1 + 2 + ... + count)`
  → `price * (count * (count + 1) // 2)`

## 🔹 `max(a, b)`
- a와 b 중 더 큰 값을 반환
- `max(0, total - money)` → 부족하지 않으면 0을 반환하도록 처리
