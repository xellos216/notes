# 터미널 환경 변수 세팅 방법

## 1. 세션에 export 해두기

``` bash
export DB_URL=jdbc:mysql://localhost:3306/testdb
export DB_USER=myuser
export DB_PASSWORD=mypassword
./gradlew bootRun
```

-   현재 터미널 세션에서만 유지됨
-   터미널을 닫으면 사라짐

------------------------------------------------------------------------

## 2. 실행 시 inline으로 붙이기

``` bash
DB_URL=jdbc:mysql://localhost:3306/testdb DB_USER=myuser DB_PASSWORD=mypassword ./gradlew bootRun
```

-   명령 실행할 때만 적용됨
-   다른 명령에는 영향 없음

------------------------------------------------------------------------

## 3. `.env` 파일 만들어두고 불러오기

### `.env` 파일 (프로젝트 루트)

``` bash
SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3306/db_name
SPRING_DATASOURCE_USERNAME=id
SPRING_DATASOURCE_PASSWORD=password
```

### 실행

``` bash
set -a
source .env
set +a
./gradlew bootRun
```

-   `.env`에 모아두고 필요할 때 불러옴
-   반복 실행 시 편리함

------------------------------------------------------------------------

## 정리

-   **1번**: 세션 전체에 유지
-   **2번**: 실행 한 번만 적용
-   **3번**: `.env` 파일로 관리, 재사용에 적합
