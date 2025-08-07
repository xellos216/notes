## `datetime.date(yyyy, mm, dd)`
- 날짜 객체 생성
- 예: `datetime.date(2016, 5, 24)`

## `.strftime('%a')`
- 요일의 3글자 문자열 반환
- 예: `'Tue'`, `'Wed'`, ...

## 윤년 월별 날짜 수
```python
month_days = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
```

## 누적 일 수 계산
```python
total_days = sum(month_days[:a - 1]) + (b - 1)
```

## 요일 리스트와 인덱싱
```python
days = ["FRI", "SAT", "SUN", "MON", "TUE", "WED", "THU"]
return days[total_days % 7]
```
→ 기준일(1월 1일)이 금요일이기 때문에 `FRI`부터 시작
