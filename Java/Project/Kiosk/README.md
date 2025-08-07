# ☕ Java kiosk Mini Project

* Java를 통해 카페 키오스크의 전체 구매 흐름을 콘솔 환경으로 구현 

---

## 🎯 프로젝트 개요

- **주요 목적**: 카테고리 선택 → 메뉴 선택 → 온도 옵션 → 수량 입력 → 장바구니 담기 → 할인 선택 → 결제까지의 전체 흐름 구현
- **기술 스택**: Java (콘솔 기반), 추후 Spring Boot 기반 웹 버전으로 확장 예정
- **진입점 클래스**: `Main.java`

---

## 🗂 디렉토리 구조

```
src/
└── kiosk/
    ├── Main.java
    ├── model/
    │   ├── CartItem.java
    │   ├── Cart.java
    │   ├── Category.java
    │   ├── Menu.java
    │   └── UserType.java
    ├── service/
    │   └── KioskService.java
    └── util/
        └── InputHandler.java
```

---

## 🧱 클래스 기능

| 클래스 | 역할 |
|--------|------|
| `Main` | 사용자 흐름 제어: 시작 화면, 카테고리 선택, 메뉴 담기, 결제 등 |
| `Menu` | 메뉴 항목 모델 (이름, 가격, 카테고리 포함) |
| `Category (enum)` | 카테고리 타입 정의 (`COFFEES`, `NON_COFFEES`, `DESSERTS`) |
| `CartItem` | 장바구니 항목 단위 (메뉴 + 수량 + 온도 옵션) |
| `Cart` | 전체 장바구니 관리, 스트림 기반 중복 검사 및 총액 계산 적용 |
| `KioskService` | 기능 전반 로직 처리: 출력, 입력, 장바구니 추가 등 |
| `UserType (enum)` | 사용자 할인 유형 정의 (`CAT`, `DOG`, `IDIOT`) 및 할인율 반환 |
| `InputHandler` | 사용자 입력 처리 및 예외 제어 담당 |

---

## 🧩 기능 흐름 요약

1. 카테고리 출력 및 선택  
2. 해당 카테고리 메뉴 출력  
3. (음료류) ICE/HOT 옵션 선택  
4. 수량 입력 및 장바구니 추가  
5. 장바구니 확인, 삭제 또는 결제  
6. 할인 유형 선택 (`CAT`, `DOG`, `IDIOT`) 및 할인율 적용  
7. 결제 완료 or 주문 취소 후 종료  
