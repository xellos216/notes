#### 기본 CRUD 실습 (Ubuntu + MySQL)

#### 🗓️ 학습 목표
- MySQL 설치 및 사용자 계정 생성
- 데이터베이스 및 테이블 생성
- INSERT / SELECT / UPDATE / DELETE 기초 실습

---

#### ✅ 실습 내용

#### 1. 사용자 생성 및 접속

```sql
CREATE USER 'h'@'localhost' IDENTIFIED BY 'h';
GRANT ALL PRIVILEGES ON *.* TO 'h'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

mysql -u h -p

CREATE DATABASE testdb;
USE testdb;

2. 데이터베이스 및 테이블 생성
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(100),
  age INT
);

3. 데이터 삽입
INSERT INTO users (name, email, age) VALUES
('홍길동', 'hong@example.com', 30),
('김철수', 'kim@example.com', 25),
('이영희', 'lee@example.com', 28);

4. 데이터 조회
SELECT * FROM users;
SELECT name, age FROM users WHERE age > 26;

5. 데이터 수정 및 삭제
UPDATE users SET age = 31 WHERE name = '홍길동';
DELETE FROM users WHERE name = '김철수';

6. 최종 상태 확인
SELECT * FROM users;

---

#### SQL 제약조건 실습 요약

#### ✅ 학습 개요

이번 실습에서는 MySQL에서 데이터 무결성을 유지하기 위한 "제약조건(Constraints)"을 직접 작성하고 테스트했다. 테이블 생성 시 어떤 규칙을 줄 수 있으며, 어떤 상황에서 오류가 발생하는지를 실습을 통해 확인했다.

---

#### 🔧 제약조건이란?

**제약조건(CONSTRAINT)**은 테이블에 입력되는 데이터의 정확성과 일관성을 보장하기 위해 사용하는 규칙이다.

#### 주요 제약조건 정리:

| 제약조건          | 설명                                                           |
| ------------- | ------------------------------------------------------------ |
| `NOT NULL`    | 해당 컬럼에 절대로 NULL 값을 허용하지 않음 (비워둘 수 없음)                        |
| `DEFAULT`     | 값을 입력하지 않으면 자동으로 들어가는 기본값 설정                                 |
| `UNIQUE`      | 테이블 내에서 중복된 값을 허용하지 않음 (고유값)                                 |
| `PRIMARY KEY` | 한 테이블에서 각 행(row)을 유일하게 식별하는 키 (자동으로 NOT NULL + UNIQUE 속성 포함) |
| `FOREIGN KEY` | 다른 테이블의 PRIMARY KEY를 참조하여 테이블 간 관계를 설정함                      |

---

#### 🧱 1. 테이블 생성 및 제약조건 설정

#### users 테이블 구조

```sql
CREATE TABLE users (
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL DEFAULT '',
    age INT DEFAULT 0,
    CONSTRAINT unique_email UNIQUE (email),
    CONSTRAINT pk_users PRIMARY KEY (id)
);

```

- `id`: 각 사용자 고유 식별자, NULL 불가, PRIMARY KEY
- `name`: 사용자 이름, 필수 입력
- `email`: 이메일 주소, 고유해야 하며 비워둘 수 없음, 기본값은 빈 문자열
- `age`: 나이, 입력하지 않으면 0으로 설정됨

#### orders 테이블 구조

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    product VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

```

- `order_id`: 주문 번호, 고유한 값 (PRIMARY KEY)
- `user_id`: 주문한 사용자 ID, `users(id)`를 참조 (FOREIGN KEY)
- `product`: 주문한 제품명

---

#### 🧪 2. 제약조건 테스트

#### ✅ UNIQUE 제약조건 테스트

```sql
-- 성공: 새로운 이메일
INSERT INTO users (id, name, email) VALUES (3, 'CHARLIE', 'charlie@example.com');

-- 실패: 같은 이메일로 중복 입력 시도
INSERT INTO users (id, name, email) VALUES (4, 'DAVID', 'charlie@example.com');
-- 결과: ERROR 1062 - Duplicate entry 'charlie@example.com' for key 'users.unique_email'

```

#### ✅ FOREIGN KEY 제약조건 테스트

```sql
-- 성공: user_id = 2 는 실제 users 테이블에 존재
INSERT INTO orders (order_id, user_id, product)
VALUES (1001, 2, 'Mechanical Keyboard');

-- 실패: user_id = 999 는 존재하지 않음
INSERT INTO orders (order_id, user_id, product)
VALUES (1002, 999, 'Gaming Mouse');
-- 결과: ERROR 1452 - Cannot add or update a child row: a foreign key constraint fails

```

---

#### 📌 새로 등장한 명령어/개념 정리

| 명령어 / 개념                     | 설명                          |
| ---------------------------- | --------------------------- |
| `CREATE TABLE`               | 새로운 테이블 생성                  |
| `ALTER TABLE`                | 기존 테이블의 구조를 수정 (제약조건 추가 등)  |
| `INSERT INTO ... VALUES ...` | 테이블에 새 데이터를 삽입              |
| `SHOW TABLES;`               | 현재 데이터베이스의 모든 테이블 목록 확인     |
| `DESC 테이블명;`                 | 테이블 구조(컬럼과 속성) 간단히 확인       |
| `SHOW CREATE TABLE 테이블명 \G;` | 전체 테이블 생성 SQL을 확인 (제약조건 포함) |

---

#### 📚 정리

이번 실습을 통해 단순히 데이터를 저장하는 것을 넘어서, **데이터의 유효성을 자동으로 검증하는 구조**를 만들 수 있다는 점을 배웠다. 제약조건은 개발자가 서버 로직에서 실수하지 않아도 되게 하는 "안전망"의 역할을 한다. 실무에서는 이 구조를 기반으로 웹서버(Spring, Django 등)에서 사용자 입력을 받아 SQL로 저장하는 방식으로 연결된다.

다음 단계에서는 실무에서 자주 사용되는 JOIN, GROUP BY, TRANSACTION 등의 개념을 실습하며 데이터베이스 활용도를 높일 예정이다.

---

#### SQL JOIN 실습 요약

#### ✅ 학습 개요

이번 실습에서는 MySQL에서 관계형 데이터 간 연결을 위한 **JOIN**을 직접 작성하고, 그 동작 방식을 테스트했다. 특히 `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`의 차이를 비교하면서 결과를 눈으로 확인했다.

---

#### 🔧 JOIN 이란?

`JOIN`은 여러 테이블을 연결해 하나의 결과로 출력하는 SQL 문법이다.

---

#### 🧱 실습한 테이블

#### users 테이블

```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    age INT DEFAULT 0
);

```

#### products 테이블

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price INT NOT NULL
);

```

#### orders_v2 테이블

```sql
CREATE TABLE orders_v2 (
    order_id INT PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

```

---

#### 🧪 JOIN 실습

#### ✅ INNER JOIN

```sql
SELECT u.name, p.name, o.quantity
FROM orders_v2 o
INNER JOIN users u ON o.user_id = u.id
INNER JOIN products p ON o.product_id = p.product_id;

```

→ 조건을 만족하는 행만 결과로 출력 (교집합)

---

#### ✅ LEFT JOIN

```sql
SELECT u.name, p.name, o.quantity
FROM users u
LEFT JOIN orders_v2 o ON u.id = o.user_id
LEFT JOIN products p ON o.product_id = p.product_id;

```

→ 모든 회원을 포함하며, 주문이 없는 회원은 `NULL`

---

#### ✅ RIGHT JOIN

```sql
SELECT p.name, u.name, o.quantity
FROM products p
RIGHT JOIN orders_v2 o ON p.product_id = o.product_id
RIGHT JOIN users u ON o.user_id = u.id;

```

→ 모든 주문을 기준으로 출력하며, 매칭 안 되는 항목은 `NULL`

---

#### JOIN 시각화 요약 (기준: users, orders_v2, products)

1. INNER JOIN
┌───────────────┬───────────────┐
│     users     │   orders_v2   │
│  (회원 전체)  │ (주문 내역)   │
├───────────────┴───────────────┤
│ ❗ user_id가 일치하는 행만    │
│     → 주문이 있는 회원만     │
└──────────────────────────────┘

결과: 주문한 회원 + 주문한 상품만

예:
- 홍길동 (주문 O)
- BOB (주문 O)
- CHARLIE (주문 X → 결과에 없음)

---

2. LEFT JOIN
┌───────────────┬───────────────┐
│     users     │   orders_v2   │
│  (기준 테이블)│               │
├───────────────┴───────────────┤
│ ✅ 모든 회원은 무조건 포함     │
│    ❗ 주문이 없으면 NULL로 표시│
└──────────────────────────────┘

결과: 전체 회원 + 주문 여부 확인

예:
- 홍길동 ✅
- BOB ✅
- CHARLIE ❌ (NULL)

→ "누가 주문 안 했는지" 볼 때 유용

---

3. RIGHT JOIN
┌───────────────┬───────────────┐
│   products    │   orders_v2   │
│ (or users 등) │ (기준 테이블) │
├───────────────┴───────────────┤
│ ✅ 모든 주문은 무조건 포함     │
│    ❗ 연결 안 되면 NULL 표시   │
└──────────────────────────────┘

결과: 전체 주문 + 연결된 회원/상품 여부

예:
- 주문한 상품 ✅
- 주문에 매칭 안 된 회원/상품 ❌ (NULL)

→ "주문 데이터 중심 분석"에 유리


#### 📚 핵심 요약

| JOIN 종류    | 기준 테이블   | 포함 범위              | 용도 예시                        |
|--------------|----------------|-------------------------|-----------------------------------|
| `INNER JOIN` | 공통 기준       | 양쪽 테이블 모두 일치   | 실제 주문 내역 추출              |
| `LEFT JOIN`  | 왼쪽 테이블     | 왼쪽 전부 + 오른쪽 일부 | 전체 회원 중 미주문자 확인       |
| `RIGHT JOIN` | 오른쪽 테이블   | 오른쪽 전부 + 왼쪽 일부 | 전체 주문 기준 상품/회원 분석    |

---

#### SQL Aggregation, GROUP BY, HAVING

이번 학습에서는 실무에서 자주 사용되는 **집계 함수**, **GROUP BY**, **HAVING** 절을 중심으로 실습을 진행하였다.

---

#### 🔹 1. 회원별 총 주문 수량

```sql
SELECT
  u.name AS user_name,                      -- 회원 이름을 user_name으로 표시
  SUM(o.quantity) AS total_quantity        -- 주문 수량 합계를 total_quantity로 표시
FROM
  users u                                  -- users 테이블을 u로 별칭 지정
JOIN
  orders_v2 o ON u.id = o.user_id          -- 회원 ID 기준으로 조인
GROUP BY
  u.id;                                    -- 회원별로 그룹화하여 집계

```

---

#### 🔹 2. 상품별 판매량 합계

```sql
SELECT
  p.name AS product_name,                  -- 상품 이름을 product_name으로 표시
  SUM(o.quantity) AS total_sold            -- 주문된 수량 총합을 total_sold로 표시
FROM
  products p                               -- products 테이블을 p로 별칭 지정
JOIN
  orders_v2 o ON p.product_id = o.product_id  -- 상품 ID 기준으로 조인
GROUP BY
  p.product_id;                            -- 상품별로 그룹화하여 집계

```

---

#### 🔹 3. HAVING 절로 조건 필터링

```sql
SELECT
  p.name AS product_name,
  SUM(o.quantity) AS total_sold
FROM
  products p
JOIN
  orders_v2 o ON p.product_id = o.product_id
GROUP BY
  p.product_id
HAVING
  total_sold >= 2;                         -- 판매량이 2개 이상인 상품만 필터링

```

🔸 `HAVING`은 `GROUP BY` 이후 집계된 결과를 조건으로 걸 때 사용하며, `WHERE`은 집계 이전 조건 필터링에 사용된다.

---

#### 🔹 4. 집계 함수 총정리

```sql
SELECT
  p.name AS product_name,
  COUNT(o.order_id) AS order_count,        -- 주문된 횟수
  SUM(o.quantity) AS total_quantity,       -- 총 주문 수량
  AVG(o.quantity) AS avg_quantity,         -- 평균 주문 수량
  MAX(o.quantity) AS max_quantity,         -- 최대 주문 수량
  MIN(o.quantity) AS min_quantity          -- 최소 주문 수량
FROM
  products p
JOIN
  orders_v2 o ON p.product_id = o.product_id
GROUP BY
  p.product_id;

```

---

#### ✅ 개념 요약

- **GROUP BY**: 특정 컬럼을 기준으로 결과를 그룹화함
- **HAVING**: 그룹화된 집계 결과에 조건을 걸 때 사용
- **집계 함수**:

  - `COUNT()`: 갯수 세기
  - `SUM()`: 합계
  - `AVG()`: 평균
  - `MAX()`, `MIN()`: 최대값, 최소값

이후 실무 확장으로는 `GROUP BY + 날짜`, `JOIN + 다대일 관계`, `LIMIT`, `윈도우 함수` 등으로 이어질 수 있다.

---

#### 서브쿼리(Subquery)

#### ✅ 오늘의 목표
서브쿼리는 SQL 쿼리 안에 또 다른 쿼리를 포함하는 구조로, 복잡한 조건을 처리하거나 집계 결과를 활용할 수 있게 해준다.  
실무에서 `JOIN`과 함께 가장 자주 쓰이는 고급 SQL 기법 중 하나다.

---

#### 🧩 서브쿼리란?

> 하나의 쿼리 내부에서 **또 다른 SELECT 쿼리**를 사용하는 방식

- `SELECT` 절에서 사용 → 특정 값을 가져와 출력
- `FROM` 절에서 사용 → 결과를 가상 테이블처럼 활용
- `WHERE` 절에서 사용 → 조건에 해당하는 행만 필터링
- 다양한 연산자와 함께 사용: `IN`, `EXISTS`, `=`, `>`, 등

---

#### 1️⃣ SELECT 절에서 사용하는 서브쿼리

🔸 **사용 예 (이론상)**

```sql
SELECT 
  (SELECT name FROM users WHERE users.id = o.user_id) AS user_name,
  (SELECT name FROM products WHERE products.product_id = o.product_id) AS product_name,
  o.quantity
FROM orders_v2 o;

```

🔸 **실습 결과:**  
MySQL에서는 `SELECT` 절 내부 서브쿼리에서 외부 alias(`o.user_id`)를 사용할 때 오류 발생함.  
👉 실무에서도 **JOIN 방식으로 대체**하는 것이 일반적.

---

#### 2️⃣ FROM 절에서 사용하는 서브쿼리

🔸 **사용 예**

```sql
SELECT u.name, summary.total_amount
FROM users u
JOIN (
  SELECT o.user_id, SUM(p.price * o.quantity) AS total_amount
  FROM orders_v2 o
  JOIN products p ON o.product_id = p.product_id
  GROUP BY o.user_id
) AS summary
ON u.id = summary.user_id;

```

🔸 **해석**  
- `orders_v2`와 `products`를 먼저 JOIN해서 사용자별 구매 총액(`SUM`)을 계산
- 그 결과를 `summary`라는 가상 테이블로 만든 뒤, `users`와 다시 JOIN

🔸 **결과 예**
| name | total_amount |
|------|--------------|
| Hong | 1250000      |
| BOB  | 45000        |

---

#### 3️⃣ WHERE 절에서 사용하는 서브쿼리

🔸 **사용 예**

```sql
SELECT name
FROM products
WHERE product_id IN (
  SELECT product_id
  FROM orders_v2
  WHERE user_id = (
    SELECT id FROM users WHERE name = 'Hong'
  )
);

```

🔸 **해석**
- 'Hong'의 사용자 ID를 찾고
- 그 사람이 주문한 `product_id`를 추출
- 해당 상품의 이름을 `products`에서 조회

🔸 **결과 예**

```

노트북
마우스

```

---

#### 4️⃣ 다양한 연산자와 서브쿼리

#### (1) `IN`

```sql
SELECT DISTINCT name
FROM products
WHERE product_id IN (
  SELECT product_id
  FROM orders_v2
  WHERE user_id IN (
    SELECT id FROM users WHERE age BETWEEN 20 AND 29
  )
);

```

→ 20대 사용자가 주문한 상품

---

#### (2) `EXISTS`

```sql
SELECT name
FROM products p
WHERE EXISTS (
  SELECT 1
  FROM orders_v2 o
  WHERE o.product_id = p.product_id
);

```

→ 주문 이력이 있는 상품만 조회

---

#### (3) `=` 단일 결과

```sql
SELECT name
FROM products
WHERE price = (
  SELECT MAX(price)
  FROM products
);

```

→ 가장 비싼 상품 출력 (예: '노트북')

---

#### 5️⃣ JOIN vs 서브쿼리 비교 실습

#### (1) 서브쿼리 방식

```sql
SELECT 
  u.name,
  (SELECT SUM(p.price * o.quantity)
   FROM orders_v2 o
   JOIN products p ON o.product_id = p.product_id
   WHERE o.user_id = u.id) AS total_spent
FROM users u;

```

#### (2) JOIN 방식

```sql
SELECT 
  u.name,
  SUM(p.price * o.quantity) AS total_spent
FROM users u
JOIN orders_v2 o ON u.id = o.user_id
JOIN products p ON p.product_id = o.product_id
GROUP BY u.id;

```

---

#### ✅ 기본 비교

| 항목 | `JOIN` | `서브쿼리` |
|------|--------|------------|
| **기본 개념** | 여러 테이블을 **한 줄에 병합**하여 조회 | 다른 쿼리 안에 포함된 **중첩 쿼리** |
| **사용 위치** | `FROM`, `ON`, `WHERE`, `SELECT` 등 | 주로 `WHERE`, `SELECT`, `FROM` 내부 |
| **성능** | 인덱스가 잘 잡히면 일반적으로 빠름 | 작은 데이터에는 무방, 큰 데이터엔 느려질 수 있음 |
| **가독성** | 명확한 테이블 관계 표현에 유리 | 간단한 조건 필터링에는 깔끔함 |
| **유형** | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, 등 | `IN`, `EXISTS`, `=`, `SELECT 절`, `FROM 절` 등 |
| **대표 예시** | 유저와 주문 테이블을 조인하여 이름과 구매 내역 조회 | 특정 조건(예: 가장 비싼 상품)으로 필터링 |
| **주의사항** | `JOIN` 후 `GROUP BY` 필수인 경우 있음 | `SELECT` 절에서는 MySQL 버전에 따라 외부 alias 인식 제한 있음 |

---

#### ✅ 언제 어떤 걸 써야 할까?

| 상황 | 추천 방식 | 이유 |
|------|------------|------|
| **두 테이블을 연결해 데이터를 함께 보고 싶을 때** | `JOIN` | 관계형 데이터 활용에 최적 |
| **특정 조건 만족 여부만 확인하고 싶을 때** | `EXISTS`, `IN` 서브쿼리 | 짧고 직관적 |
| **단일 값 비교** (예: MAX, MIN) | `=` 서브쿼리 | 계산 대상이 하나일 때 적합 |
| **외부 테이블과 관계 없는 단독 필터** | 서브쿼리 | 간결함 유지 |
| **여러 조건을 동시에 계산하거나 요약해야 할 때** | `JOIN + GROUP BY` | 통계, 집계 연산에 최적 |

---

#### 📌 실습에서 배운 점

- **MySQL에서 SELECT 절 서브쿼리는 외부 alias 사용 시 제한이 있음**
- **FROM 절 서브쿼리는 집계 결과를 다룰 때 매우 유용함**
- **WHERE 절 서브쿼리는 단순 조건 필터링에 적합함**
- **JOIN은 다중 테이블 결합에 최적, 성능 면에서 서브쿼리보다 일반적으로 유리함**
- **상황에 맞게 JOIN과 서브쿼리를 선택하는 전략이 중요함**

---

#### 🧠 어려웠던 이유 & 팁

서브쿼리는 쿼리 안에 쿼리가 들어가 있기 때문에 **처음에는 읽는 순서가 헷갈리고**,  
`FROM`, `WHERE`, `JOIN`에서의 문맥 차이를 익히는 데 시간이 걸림.

> 🔸 팁: **안쪽부터 해석하라!**  
> 서브쿼리는 항상 안쪽 쿼리를 먼저 실행한다고 생각하고 읽는 것이 핵심.

---
