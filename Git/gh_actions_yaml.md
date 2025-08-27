# ✅ YAML & GitHub Actions 정리

------------------------------------------------------------------------

## 1. YAML 기본 문법

### 1-1. 기본 구조

``` yaml
key: value
```

### 1-2. 들여쓰기

-   **스페이스만 사용 (탭 금지)**\

``` yaml
jobs:
  build:
    runs-on: ubuntu-latest
```

### 1-3. 리스트

``` yaml
branches:
  - main
  - dev
```

### 1-4. 불리언, 숫자, Null

``` yaml
enabled: true
retries: 3
value: null
```

### 1-5. 문자열

``` yaml
message: hello
message_with_space: "hello world"
```

### 1-6. 주석

``` yaml
# 이건 주석
name: CI
```

------------------------------------------------------------------------

## 2. GitHub Actions 워크플로우 기본 패턴

``` yaml
name: CI

on:
  push:
    branches:
      - main
      - dev

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.12"

      - name: Install deps
        run: pip install -r requirements.txt

      - name: Run linter
        run: ruff check .
```

------------------------------------------------------------------------

## 3. YAML에서 자주 나는 에러 5가지

1.  **탭 사용**
    -   ❌ `` (탭) 사용 → 파싱 에러\
    -   ✅ 스페이스로 들여쓰기
2.  **들여쓰기 불일치**
    -   ❌

        ``` yaml
        jobs:
          build:
             runs-on: ubuntu-latest
        ```

    -   ✅

        ``` yaml
        jobs:
          build:
            runs-on: ubuntu-latest
        ```
3.  **콜론(:) 뒤 공백 누락**
    -   ❌ `name:CI`\
    -   ✅ `name: CI`
4.  **리스트 기호(-)와 값 사이 공백 없음**
    -   ❌

        ``` yaml
        branches:
          -main
        ```

    -   ✅

        ``` yaml
        branches:
          - main
        ```
5.  **문자열 따옴표 문제**
    -   ❌ `python-version: '3.12"` (따옴표 불일치)\
    -   ✅ `python-version: "3.12"`

------------------------------------------------------------------------

## 4. 실무에서 많이 쓰는 CI 파이프라인 샘플

### 4-1. Python 프로젝트

``` yaml
name: Python CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: "3.11"
      - run: pip install -r requirements.txt
      - run: pytest   # 테스트 실행
      - run: ruff check .
      - run: black --check .
```

------------------------------------------------------------------------

### 4-2. Node.js 프로젝트

``` yaml
name: Node.js CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: "20"
      - run: npm install
      - run: npm run lint
      - run: npm test
```

------------------------------------------------------------------------

### 4-3. Java (Spring) 프로젝트

``` yaml
name: Java CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          java-version: "17"
          distribution: "temurin"
      - run: ./gradlew build --no-daemon
      - run: ./gradlew test --no-daemon
```

------------------------------------------------------------------------

# 📌 정리

-   YAML = 단순한 데이터 표현 언어 (들여쓰기, 리스트, key-value만 잘
    지키면 됨).\
-   GitHub Actions = YAML 문법 + GitHub DSL 키워드(`on`, `jobs`,
    `steps`, `uses`, `run`).\
-   CI 파이프라인은 언어별로 달라지지만 **패턴은 동일** → Checkout →
    환경 설정 → 의존성 설치 → 빌드/테스트/검증.
