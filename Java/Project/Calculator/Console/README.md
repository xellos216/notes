# 🧮 Java Console Calculator

## ✅ 기능

- `+`, `-`, `*`, `/`, `^`, `sqrt` 연산자 지원
- `sqrt`는 단항 연산으로 두 번째 숫자 없이 처리
- 잘못된 숫자 및 연산자 입력 시 반복 유도
- 계산 결과를 리스트에 저장 → `Max`, `Min`, `Sum` 자동 출력
- `[ History ]` 형태로 전체 결과 목록 출력
- **소수점 5자리 고정 포맷 출력** (`%.5f`)

---

## 💡 출력 예시

```text
=== Calculator ===
Enter first number (or 'exit'): 64
Enter operator (+, -, *, /, ^, sqrt): sqrt
= 8.00000

[ Stats from previous results ]
Max result: 8.00000
Min result: 8.00000
Sum of all results: 8.00000

[ History ] 
[8.00000]
```

---

## 📁 구조

| 파일명 | 설명 |
|--------|------|
| `Main.java` | 사용자 입력 처리, 연산 분기, UI 호출 담당 |
| `ArithmeticCalculator.java` | 계산 실행, 결과 저장 및 통계 추출 |
| `ArithmeticOperator.java` | 연산자 기호 정의 및 람다식 연산 처리 |
| `CalculatorUI.java` | 사용자 입력/출력 및 오류/통계 메시지 담당 |
| `SafeRunner.java` | 예외 발생 방지용 래퍼 함수 구현 |

---

## 🔖 학습 포인트

- `Enum`을 활용한 연산자 정의 및 단항/이항 분기
- 람다와 Stream을 통한 `min()`, `max()`, `sum()` 구현
- `List<Double>` 기반 결과 저장 및 출력 포맷 통제
- 사용자 친화적 CLI 흐름 설계 (`exit`, 잘못된 입력 재요청 등)
- UI와 계산 로직 분리된 구조 설계



