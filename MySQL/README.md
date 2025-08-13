# MySQL Commands

## ✅ 접속 & 종료

```bash
mysql -u 사용자명 -p         # MySQL 접속 (비밀번호 입력 필요)
exit                         # MySQL CLI 종료
```

---

## ✅ 데이터베이스 관련

```sql
SHOW DATABASES;              -- 전체 데이터베이스 목록 확인
CREATE DATABASE db명;        -- 새 데이터베이스 생성
USE db명;                    -- 특정 데이터베이스로 전환
DROP DATABASE db명;          -- 데이터베이스 삭제
```

---

## ✅ 테이블 관련

```sql
SHOW TABLES;                 -- 현재 데이터베이스의 테이블 목록
DESCRIBE 테이블명;           -- 테이블 구조(컬럼, 타입 등) 확인
SHOW COLUMNS FROM 테이블명;  -- DESCRIBE와 동일

CREATE TABLE 테이블명 (...); -- 테이블 생성
DROP TABLE 테이블명;         -- 테이블 삭제
```

---

## ✅ 데이터 조작 (CRUD)

```sql
-- INSERT
INSERT INTO 테이블명 (컬럼1, 컬럼2) VALUES (값1, 값2);

-- SELECT
SELECT * FROM 테이블명;
SELECT 컬럼명 FROM 테이블명 WHERE 조건;

-- UPDATE
UPDATE 테이블명 SET 컬럼명 = 값 WHERE 조건;

-- DELETE
DELETE FROM 테이블명 WHERE 조건;
```

---

## ✅ 정렬, 조건, 제한

```sql
SELECT * FROM 테이블명
WHERE 조건
ORDER BY 컬럼명 DESC
LIMIT 10;
```

---

## ✅ 집계 함수 & GROUP BY

```sql
SELECT COUNT(*) FROM 테이블명;
SELECT 컬럼명, SUM(다른컬럼) FROM 테이블명 GROUP BY 컬럼명;
```

---

## ✅ JOIN

```sql
SELECT *
FROM A
JOIN B ON A.key = B.key;

-- LEFT JOIN 예시
SELECT *
FROM A
LEFT JOIN B ON A.key = B.key;
```

---

## ✅ 인덱스 관련

```sql
CREATE INDEX 인덱스명 ON 테이블명(컬럼명);
DROP INDEX 인덱스명 ON 테이블명;
SHOW INDEX FROM 테이블명;
```

---

## ✅ 트랜잭션 관련

```sql
START TRANSACTION;   -- 또는 BEGIN;
UPDATE ...;          -- 여러 쿼리 실행
COMMIT;              -- 변경사항 확정
ROLLBACK;            -- 변경사항 되돌리기
```

---

## ✅ 기타 유용한 명령어

```sql
STATUS;                      -- 현재 접속 상태 및 정보 확인
SOURCE 파일경로.sql;         -- SQL 파일 실행
SHOW PROCESSLIST;            -- 현재 실행 중인 쿼리 목록 확인
mysqldump -u [사용자이름] -p [데이터베이스이름] > [저장할파일명].sql     -- 현재 디렉토리에 dump 파일 생성

```

