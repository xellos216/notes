## 🔹 `enumerate(answers)`
- 인덱스와 값을 함께 순회할 수 있음
- `i`는 인덱스, `a`는 해당 문제의 정답

## 🔹 리스트 컴프리헨션 + 조건식
```python
sum([p[i % len(p)] == a for i, a in enumerate(answers)])
```
- 패턴의 현재 위치와 정답을 비교해서 맞은 개수만 누적

## 🔹 패턴 반복
- `p[i % len(p)]` → 패턴이 짧아도 인덱스를 순환시켜 반복 구현 가능
