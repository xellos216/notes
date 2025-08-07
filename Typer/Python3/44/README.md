## 🧠 Problem
각 명함의 크기가 `[w, h]` 형식으로 주어질 때,  
모든 명함을 **회전해서라도** 수납할 수 있는 **최소 지갑의 크기**를 구하시오.

- 명함은 회전 가능 (즉, [60, 30]도 [30, 60]처럼 수납 가능)
- 지갑은 한 방향으로만 가로, 세로를 고정해야 함

### Constraints
- 1 ≤ sizes의 길이 ≤ 10,000
- 1 ≤ w, h ≤ 1,000

### Example

- Input:
```python
[[60, 50], [30, 70], [60, 30], [80, 40]]
```

- Output: `4000`

→ 최대 가로: 80, 최대 세로: 50 → `80 × 50 = 4000`

---

## 🐍 Python Reference Code

```python
def solution(sizes):
    max_w = 0
    max_h = 0
    for w, h in sizes:
        w, h = max(w, h), min(w, h)
        max_w = max(max_w, w)
        max_h = max(max_h, h)
    return max_w * max_h
```
