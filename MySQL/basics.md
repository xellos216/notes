# SQL 기초

## 1. 데이터베이스(Database)와 테이블(Table)
- **데이터베이스(Database)**: 여러 테이블을 포함하는 큰 단위
- **테이블(Table)**: 행(row)과 열(column)로 구성된 데이터 구조
  - 각 행은 하나의 레코드, 각 열은 속성을 나타냄

## 2. SQL 기본 명령어  
SQL로 데이터베이스와 테이블 생성, 조회, 삽입, 수정, 삭제 등의 작업 수행 가능

### 2.1. 데이터베이스 생성
```sql
CREATE DATABASE 데이터베이스이름;
```

### 2.2. 테이블 생성
```sql
CREATE TABLE 테이블이름 (
  컬럼1 데이터타입,
  컬럼2 데이터타입,
  ...
);
```
**예시**:
```sql
CREATE TABLE students (
  id INT,
  name VARCHAR(50),
  age INT
);
```
- `id`: 정수(INT)  
- `name`: 최대 50자 문자열(VARCHAR(50))  
- `age`: 정수(INT)  

### 2.3. 데이터 조회 (SELECT)
```sql
SELECT 컬럼1, 컬럼2 FROM 테이블이름;
```
**예시**:
```sql
SELECT name, age FROM students;
```

- **WHERE**: 조건 필터  
  ```sql
  SELECT name, age FROM students WHERE age > 20;
  ```
- **ORDER BY**: 정렬  
  ```sql
  SELECT name, age FROM students ORDER BY age DESC;
  ```
- **LIMIT**: 행 수 제한  
  ```sql
  SELECT name, age FROM students LIMIT 5;
  ```

### 2.4. 데이터 삽입 (INSERT)
```sql
INSERT INTO 테이블이름 (컬럼1, 컬럼2, ...)
VALUES (값1, 값2, ...);
```
**예시**:
```sql
INSERT INTO students (id, name, age) VALUES (1, 'Alice', 23);
```

### 2.5. 데이터 수정 (UPDATE)
```sql
UPDATE 테이블이름
SET 컬럼1 = 값1, 컬럼2 = 값2
WHERE 조건;
```
**예시**:
```sql
UPDATE students SET age = 24 WHERE id = 1;
```

### 2.6. 데이터 삭제 (DELETE)
```sql
DELETE FROM 테이블이름 WHERE 조건;
```
**예시**:
```sql
DELETE FROM students WHERE id = 1;
```

## 3. 기본 키(Primary Key)와 외래 키(Foreign Key)
- **기본 키**: 각 행을 고유하게 식별하는 열 또는 열 조합
- **외래 키**: 다른 테이블의 기본 키를 참조하는 열, 테이블 간 관계 표현

**예시**:
```sql
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  student_id INT,
  FOREIGN KEY (student_id) REFERENCES students(id)
);
```

## 4. 집계 함수 (Aggregate Functions)
- `COUNT()`: 행 개수 세기  
  ```sql
  SELECT COUNT(*) FROM students;
  ```
- `SUM()`: 합계  
  ```sql
  SELECT SUM(age) FROM students;
  ```
- `AVG()`: 평균  
  ```sql
  SELECT AVG(age) FROM students;
  ```
- `MAX()`: 최대값  
  ```sql
  SELECT MAX(age) FROM students;
  ```
- `MIN()`: 최소값  
  ```sql
  SELECT MIN(age) FROM students;
  ```

## 5. SQL 조건문
- `AND`: 두 조건 모두 만족  
  ```sql
  SELECT * FROM students WHERE age > 20 AND name = 'Alice';
  ```
- `OR`: 하나의 조건만 만족하면 됨  
  ```sql
  SELECT * FROM students WHERE age > 20 OR name = 'Bob';
  ```
- `NOT`: 조건 부정  
  ```sql
  SELECT * FROM students WHERE NOT age > 20;
  ```
