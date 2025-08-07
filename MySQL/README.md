# SQL CLI Study - 통합 README

> **목표**: Kotlin & Spring 백엔드 개발에 필요한 관계형 데이터베이스(SQL) 기초 및 실무 활용 흐름 예습  
> **환경**: Ubuntu 22.04, MySQL 8.x, CLI 기반 실습

---

## ✅ 학습 개요

본 예습은 CLI 환경에서 MySQL을 직접 다루며, SQL의 기초 문법부터 실무에서 자주 사용하는 고급 쿼리까지 단계별로 학습하는 것을 목표로 한다.  
또한, 단순한 명령어 암기보다 **웹 백엔드와의 연결 구조**를 이해하고, 실무에서 SQL이 어떤 역할을 하는지를 체험적으로 익힌다.

---

## 📚 학습 흐름 요약

| 주제 | 주요 실습 항목 |
|------|----------------|
| SQL 기본 구조 | DB 및 사용자 생성, 테이블 생성, INSERT / SELECT / UPDATE / DELETE |
| 제약조건 | NOT NULL, UNIQUE, DEFAULT, PRIMARY KEY, FOREIGN KEY |
| JOIN | INNER / LEFT / RIGHT JOIN 실습, 테이블 간 관계 설정 |
| 집계와 그룹화 | GROUP BY, HAVING, COUNT, SUM, AVG 등 집계 함수 |
| 서브쿼리 | SELECT / FROM / WHERE 절에서의 Subquery, JOIN과 비교 |
| 종합 실습 (집계 + 서브쿼리) | JOIN + GROUP BY + HAVING + Subquery 결합 실습 |
| 인덱스 | 인덱스 생성/삭제, EXPLAIN으로 성능 분석, 복합 인덱스 |
| 트랜잭션 | BEGIN / COMMIT / ROLLBACK, auto commit 차이, 예외 처리 |
| 제약조건 총정리 | CHECK, DEFAULT, AUTO_INCREMENT 등 제약조건 복습 |
| 실전 흐름 통합 | CRUD → JOIN → GROUP BY → INDEX → 트랜잭션까지 실전 흐름 구성 |

---

## 💡 실무 연계 포인트

- **Spring 연동 관점**: 모든 테이블과 제약조건은 Spring의 JPA Entity 구조와 매핑됨
- **폼 입력 → DB 저장 흐름**: 제약조건이 백엔드 로직 없이도 데이터 무결성 보장
- **트랜잭션 활용**: 복합 작업에서 안정성 확보 (`@Transactional` 등)
- **인덱스와 성능**: 대규모 테이블 성능 최적화 시 필수 고려 사항

---

## ✅ 향후 확장 계획

- Spring + JPA 연동 실습으로 확장  
- SQL → Entity 매핑 / Repository 쿼리 구조 확인  
- JOIN, 트랜잭션, 인덱스가 실제 코드에서 어떻게 작동하는지 연동 예제 구성 예정
