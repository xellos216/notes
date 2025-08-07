## 🔹 `sorted()`
- 문자열이나 리스트 등을 정렬된 리스트로 반환
- 기본 정렬은 오름차순이며, `reverse=True`로 내림차순 가능
  예: `sorted("Zbcdefg", reverse=True)` → `['g', 'f', 'e', 'd', 'c', 'b', 'Z']`

## 🔹 `"".join(list)`
- 문자열 리스트를 하나의 문자열로 합침
  예: `''.join(['a', 'b', 'c'])` → `"abc"`

## 🔹 문자열은 이터러블이다
- 문자열도 `for c in s`나 `sorted(s)`처럼 반복 가능한 객체이므로 직접 정렬 가능
