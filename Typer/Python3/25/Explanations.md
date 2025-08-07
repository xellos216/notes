## 🔹 [x for x in arr if x % divisor == 0]
- 조건을 만족하는 요소들만 추출하여 새 리스트 생성

## 🔹 A if 조건 else B
- 조건이 참이면 A, 거짓이면 B 반환
  예: `result if result else [-1]`
  → `result`가 비어 있지 않으면 반환, 비었으면 `[-1]` 반환

## 🔹 `sorted()` 함수
- 리스트를 오름차순으로 정렬하여 새 리스트를 반환
  예: `sorted([3, 1, 2])` → `[1, 2, 3]`

## 🔹 result.append(x):
- append()는 리스트에 원소를 하나씩 추가하는 표준 메서드
- 위 조건이 참인 경우, 즉 x가 divisor로 나누어떨어질 경우, 해당 값을 리스트 result의 끝에 추가

