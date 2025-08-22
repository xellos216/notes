# OpenAPI 문서 활용 정리

OpenAPI 스펙(JSON)을 기반으로 Postman Collection 변환, 자동화 테스트, HTML 문서화까지 정리한 문서.

---

## 1. 도구 개요

* **openapi-to-postmanv2**
  OpenAPI(JSON) → Postman Collection(JSON) 변환 도구.

* **@redocly/cli**
  OpenAPI 문서를 HTML, Markdown 등으로 변환하는 문서화 도구.

* **newman**
  Postman Collection을 CLI에서 실행하여 자동화 테스트 가능.

---

## 2. 설치

```bash
# 필수 도구
sudo apt update
sudo apt install nodejs npm -y

# OpenAPI → Postman 변환기
sudo npm install -g openapi-to-postmanv2

# Postman CLI 실행기
sudo npm install -g newman

# Redocly CLI (문서화)
sudo npm install -g @redocly/cli
```

※ 전역 설치가 어렵다면 `npx` 사용 가능.

---

## 3. OpenAPI → Postman Collection 변환

```bash
npx openapi-to-postmanv2 -s fileName.json -o postman_collection.json -p
```

* `-s` : 입력(OpenAPI JSON)
* `-o` : 출력(Postman Collection)
* `-p` : pretty-print 옵션

### 결과 확인

```bash
jq '.info' postman_collection.json
```

### Postman Import

* Postman → `Import` → `postman_collection.json` 선택
* 자동으로 Collection 생성됨

---

## 4. Postman 자동화 테스트 (Newman)

```bash
newman run postman_collection.json
```

* 모든 요청 순차 실행
* 성공/실패 콘솔 출력

환경변수 예시:

```json
{
  "id": "env-uuid",
  "name": "local-env",
  "values": [
    { "key": "baseUrl", "value": "http://localhost:8080", "enabled": true }
  ]
}
```

실행:

```bash
newman run postman_collection.json -e postman_env.json
```

리포트:

```bash
newman run postman_collection.json -r cli,html --reporter-html-export report.html
```

---

## 5. OpenAPI → HTML/Markdown 변환 (Redocly)

### HTML 변환

```bash
npx @redocly/cli build-docs fileName.json -o fileName.html
```

### Markdown 변환

```bash
npx @redocly/cli build-docs fileName.json -o fileName.md
```

### Lint 검사

```bash
npx @redocly/cli lint fileName.json
```

---

## ✅ 최종 요약

1. OpenAPI JSON 추출
2. **openapi-to-postmanv2**로 Postman Collection 변환
3. Postman Import로 수동 테스트
4. **newman**으로 CLI 자동화 테스트 및 리포트 생성
5. **@redocly/cli**로 HTML/Markdown 문서화

---
---
---


# OpenAPI → Postman → Newman 자동화 테스트 정리

## 1. 준비

-   서버 실행 
    ``` bash
    ./gradlew bootRun
    ```
-   추출한 `postman_collection.json` 파일 필요

### Node.js & npm 설치 (없다면)

``` bash
sudo apt update
sudo apt install -y nodejs npm
node -v
npm -v
```

---

## 2. 기본 실행

``` bash
newman run postman_collection.json
```

-   컬렉션 안의 요청을 순서대로 실행\
-   같은 실행 안에서는 `Set-Cookie` 자동 재사용

---

## 3. 환경변수 파일 사용

`postman_env.json` 예시:

``` json
{
  "name": "local",
  "values": [
    { "key": "baseUrl", "value": "http://localhost:8080", "enabled": true }
  ]
}
```

실행:

``` bash
newman run postman_collection.json -e postman_env.json
```

👉 컬렉션 요청 URL을 `{{baseUrl}}/auth/login` 형태로 바꾸면 환경에 따라
쉽게 실행 가능

---

## 4. 특정 폴더만 실행

``` bash
newman run postman_collection.json --folder auth
```

-   Postman에서 만든 "auth", "users" 같은 폴더 단위만 실행 가능

---

## 5. 데이터 드리븐 테스트

`users.json` 예시:

``` json
[
  { "email": "u1@example.com", "password": "Qwer01234" },
  { "email": "u2@example.com", "password": "Qwer01234" }
]
```

요청 Body에 `{{email}}`, `{{password}}` 사용

실행:

``` bash
newman run postman_collection.json -d users.json
```

---

## 6. 리포트

``` bash
newman run postman_collection.json -r cli,html --reporter-html-export report.html
```

-   CLI 결과와 HTML 리포트(`report.html`) 생성

---

## 7. 실패 시 즉시 중단

``` bash
newman run postman_collection.json --bail
```

---

## 8. 로그인 세션 처리

### (1) 세션 쿠키 방식

-   같은 컬렉션 안에서는 자동 쿠키 재사용 → 로그인 요청이 맨 앞에 있으면
    그대로 사용 가능

### (2) JWT 토큰 방식

-   로그인 요청 → **Tests 탭**에 다음 코드 추가:

``` javascript
const data = pm.response.json().data;
pm.environment.set("token", data.token);
```

-   이후 요청의 Authorization → Bearer Token에 `{{token}}` 입력

