# GROUP BY / HAVING / JOIN / Subquery

이번 학습에서는 SQL의 핵심 개념인 `GROUP BY`, `HAVING`, `JOIN`, 그리고 `서브쿼리(Subquery)`를 결합한 집계 전략을 실습 중심으로 익혔다.

---

## 1. GROUP BY 기본 구조

- `GROUP BY`는 특정 컬럼을 기준으로 행을 묶고, 묶인 그룹에 대해 집계 함수(COUNT, SUM, AVG 등)를 적용할 때 사용한다.
- 예를 들어, 유저별 주문 횟수를 구하거나, 상품 카테고리별 평균 가격을 계산할 때 사용된다.

**기본 형식:**
```sql
SELECT 그룹기준컬럼, 집계함수
FROM 테이블명
GROUP BY 그룹기준컬럼;
```

---

## 2. WHERE vs HAVING

- `WHERE`: GROUP BY **이전**, 개별 행을 필터링
- `HAVING`: GROUP BY **이후**, 집계된 결과(그룹)에 조건을 걸 때 사용

| 구문   | 필터 대상     | 적용 시점  |
|--------|----------------|-------------|
| WHERE  | 개별 행       | GROUP BY 이전 |
| HAVING | 그룹 결과     | GROUP BY 이후 |

**예시 비교:**
```sql
-- WHERE: 주문 수량 2개 이상만 필터링
SELECT user_id, COUNT(*) 
FROM orders_v2
WHERE quantity >= 2
GROUP BY user_id;

-- HAVING: 주문 횟수가 2번 이상인 유저만 필터링
SELECT user_id, COUNT(*) 
FROM orders_v2
GROUP BY user_id
HAVING COUNT(*) >= 2;
```

---

## 3. GROUP BY + JOIN

- 여러 테이블을 JOIN한 후, 원하는 기준으로 그룹화하여 집계할 수 있다.
- 실무에서 매우 자주 사용되는 패턴으로, 예를 들어 유저별 총 결제 금액을 구할 때 사용한다.

```sql
SELECT u.name, SUM(p.price * o.quantity) AS total_spent
FROM orders_v2 o
JOIN users u ON o.user_id = u.id
JOIN products p ON o.product_id = p.product_id
GROUP BY u.name;
```

---

## 4. GROUP BY + Subquery

- 집계 결과를 서브쿼리로 감싼 뒤, 그 결과에 대해 정렬/필터링/JOIN 등을 다시 수행할 수 있다.
- 특히 "총 구매 금액이 가장 많은 유저 찾기", "Top 3 유저" 등의 상황에서 유용하다.

```sql
SELECT u.name, sub.total_spent
FROM (
  SELECT o.user_id, SUM(p.price * o.quantity) AS total_spent
  FROM orders_v2 o
  JOIN products p ON o.product_id = p.product_id
  GROUP BY o.user_id
) AS sub
JOIN users u ON sub.user_id = u.id
ORDER BY sub.total_spent DESC
LIMIT 1;
```

---

## 5. 실무 전략 요약

- 단일 테이블 분석: `GROUP BY` + 집계함수
- 조건 필터링이 필요하면: `WHERE`, 또는 집계값 조건엔 `HAVING`
- 상세 정보(이름 등) 붙이려면: `JOIN` 사용
- 상위 n개 추출, 비교 분석이 필요하면: `서브쿼리`와 `ORDER BY`, `LIMIT` 조합

실무에서 이 네 가지를 적절히 조합하면 대부분의 통계/리포트 SQL을 구성할 수 있다.

---

# INDEX

## ✅ 1. INDEX 개념 정리

| 항목 | 설명 |
|------|------|
| 정의 | 특정 컬럼의 값을 빠르게 검색하기 위한 자료구조 (보통 B-Tree) |
| 목적 | `WHERE`, `JOIN`, `ORDER BY` 시 검색 속도 향상 |
| 특징 | SELECT 성능 향상 / INSERT·UPDATE·DELETE 시 부하 증가 가능 |
| 비교 | 인덱스 없음 → Full Table Scan / 인덱스 있음 → 빠른 탐색 |

## ✅ 2. 기본 인덱스 실습

```sql
CREATE INDEX idx_users_email ON users(email);
SHOW INDEX FROM users;
EXPLAIN SELECT * FROM users WHERE email = 'hong@example.com';
```

- `type = const`, `key = unique_email`, `rows = 1` → 인덱스 최적 사용 확인
- `idx_users_email`보다 `UNIQUE` 인덱스가 우선 사용됨

## ✅ 3. 복합 인덱스 실습

```sql
CREATE INDEX idx_orders_user_product ON orders_v2(user_id, product_id);
EXPLAIN SELECT * FROM orders_v2 WHERE user_id = 1 AND product_id = 2;
```

- `key = product_id` → 단일 인덱스만 사용됨 (복합 인덱스 미사용)
- `LEFTMOST PREFIX` 원칙 주의: 복합 인덱스는 앞쪽부터 조건 충족해야 효율적

## ✅ 4. 인덱스 제거와 FOREIGN KEY

```sql
DROP INDEX idx_orders_user_product ON orders_v2; -- 실패
-- 이유: FOREIGN KEY 제약조건과 연결됨
```

**해결 흐름:**

```sql
-- 외래 키 제약조건 확인
SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'orders_v2' AND REFERENCED_TABLE_NAME IS NOT NULL;

-- 외래 키 제거
ALTER TABLE orders_v2 DROP FOREIGN KEY orders_v2_ibfk_1;
ALTER TABLE orders_v2 DROP FOREIGN KEY orders_v2_ibfk_2;

-- 인덱스 제거
DROP INDEX idx_orders_user_product ON orders_v2;
```

## ✅ 5. EXPLAIN 결과 해석 요약

| 항목 | 의미 |
|------|------|
| `type` | 접근 방식 (`const` > `ref` > `ALL`) |
| `key` | 실제 사용된 인덱스 이름 |
| `rows` | 예측 스캔 행 수 |
| `filtered` | 필터 조건 통과율 |
| `Extra` | 추가 처리 설명 (`Using where`, `Using index`, 등) |

---

# TRANSACTION

## ✅ 1. 트랜잭션(Transaction) 개념 정리

| 항목 | 설명 |
|------|------|
| 정의 | 여러 SQL 작업을 하나로 묶어, 모두 성공 또는 모두 실패하게 하는 처리 단위 |
| 목적 | 데이터 일관성과 무결성 보장 |
| 대표 성질 (ACID) | 원자성(Atomicity), 일관성(Consistency), 격리성(Isolation), 지속성(Durability) |

## ✅ 2. 트랜잭션 시작과 종료 실습

```sql
BEGIN;
UPDATE users SET age = 33 WHERE id = 1;
COMMIT; -- 또는 ROLLBACK;
```

- COMMIT 전에는 같은 세션 내에서만 변경 내용 확인 가능
- ROLLBACK 시 모든 작업 취소

## ✅ 3. 예외 상황 가정 후 ROLLBACK 실습

```sql
BEGIN;
INSERT INTO orders_v2 (user_id, product_id, quantity)
VALUES (1, 101, 1);
INSERT INTO orders_v2 (user_id, product_id, quantity)
VALUES (1, 9999, 1); -- 존재하지 않는 FK
ROLLBACK;
```

- 두 번째 INSERT에서 FOREIGN KEY 위반 발생 시 전체 트랜잭션 ROLLBACK

## ✅ 4. AUTO COMMIT 모드 비교

| 설정 | 설명 |
|------|------|
| autocommit = 1 | SQL 실행 즉시 COMMIT (기본값) |
| autocommit = 0 | COMMIT 필요, 트랜잭션처럼 동작 |
| 확인 방법 | `SELECT @@autocommit;` |
| 변경 방법 | `SET autocommit = 0;` 또는 `1;` |

## ✅ 5. 실무 트랜잭션 활용 포인트

- 은행 송금, 주문-재고-포인트 차감 등 복합 작업에 필수
- 중간 실패 발생 시 전체 롤백으로 데이터 무결성 보장
- 애플리케이션에서는 `@Transactional` 또는 JDBC 커넥션으로 제어

---

# 통합 실습 프로젝트

## ✅ 학습 목표

- 실전 데이터 흐름을 SQL로 구현 (CRUD → JOIN → GROUP BY → INDEX → 트랜잭션)
- 지금까지 배운 내용을 하나로 통합하여 실습

## ✅ 주요 실습 흐름

### 1. CRUD 실습
- INSERT: 유저 추가, 주문 등록
- UPDATE: 특정 주문 수량 수정
- DELETE: 주문 삭제
- SELECT: 전체 데이터 조회

### 2. JOIN + GROUP BY 실습
```sql
SELECT 
  u.name AS user_name,
  p.name AS product_name,
  SUM(o.quantity) AS total_qty,
  SUM(o.quantity * p.price) AS total_spent
FROM orders AS o
JOIN users AS u ON o.user_id = u.id
JOIN products AS p ON o.product_id = p.product_id
GROUP BY u.id, p.product_id
ORDER BY u.name;
```

### 3. EXPLAIN으로 인덱스 활용 확인
- 인덱스 사용 여부, join buffer 사용 여부 확인

### 4. 트랜잭션 실습
```sql
BEGIN;
INSERT INTO orders (...) VALUES (...);
INSERT INTO orders (...) VALUES (...); -- 오류 유도
ROLLBACK;
```

- 실패 시 전체 작업 되돌아감 확인

### 5. 최종 구조 정리
- orders_v2 → orders로 이름 변경
- 실무에 가까운 3개 테이블(users, products, orders)로 통일

## ✅ 실습 결과

- 트랜잭션, JOIN, INDEX, 집계, 제약조건이 통합된 쿼리 구조에 익숙해짐
- 실무에서의 데이터 흐름을 SQL만으로 충분히 재현 가능
