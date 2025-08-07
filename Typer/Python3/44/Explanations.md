## 🔹 명함 회전 처리
```python
w, h = max(w, h), min(w, h)
```
- 가로/세로를 강제로 회전시켜서 가장 넓은 쪽이 가로, 짧은 쪽이 세로가 되게 정렬

## 🔹 최대값 계산
```python
max_w = max(max_w, w)
max_h = max(max_h, h)
```
- 지금까지 본 명함 중 **가장 큰 가로, 가장 큰 세로**를 계속 업데이트

## 🔹 최종 지갑 크기
```python
return max_w * max_h
```
- 모든 명함이 들어가는 **가장 작은 지갑의 면적**
