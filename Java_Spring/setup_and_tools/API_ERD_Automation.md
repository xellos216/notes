# 1) Theory

* API: OpenAPI JSON을 “스냅샷”으로 저장하고 HTML/PDF, Postman 컬렉션으로 변환.
* ERD: 현재 DB 스키마에서 **무데이터 덤프 → ERD 이미지**를 만든다. FK가 없으면 선이 안 그어지니 FK 선언을 점검.

# 2) Example code

## A. API 스냅샷/배포물

```bash
# 1) JSON 저장
curl -s http://localhost:8080/v3/api-docs > openapi.json

# 2) HTML 생성(ReDoc 단일 파일)
npx @redocly/cli build-docs openapi.json -o api-docs.html

# 3) Postman 컬렉션
npx openapi-to-postmanv2 -s openapi.json -o postman_collection.json
```

## B. ERD 생성(순수 CLI, 권장: dbml)

```bash
# 1) 스키마만 덤프(비번 입력 프롬프트)
mysqldump -h 127.0.0.1 -P 3306 -u <USER> -p --no-data newsfeed_dev > schema.sql

# 2) SQL → DBML
npx @dbml/cli -d mysql schema.sql -o model.dbml

# 3) DBML → 이미지(발표용)
npx @dbml/cli render model.dbml -o erd.png      # PNG
# 또는
npx @dbml/cli render model.dbml -o erd.svg      # 벡터
```

### 대안: SchemaSpy(Docker)

```bash
docker run --rm -v "$PWD/erd:/output" --network=host schemaspy/schemaspy:latest \
  -t mysql -host 127.0.0.1 -port 3306 -db newsfeed_dev -u <USER> -p <PASS> -o /output
# 결과: erd/ 디렉터리에 관계 다이어그램과 HTML 리포트
```

# 3) Execution and testing method

* `api-docs.html` 브라우저로 열어 시각 확인. 필요하면 브라우저 인쇄로 PDF 생성.
* `postman_collection.json`을 Postman에서 Import.
* `erd.png`/`erd.svg`를 슬라이드에 삽입. 라인이 안 보이면 DB 테이블의 FK 제약조건을 추가 후 덤프를 다시 생성.
