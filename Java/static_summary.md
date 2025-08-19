# Java `static` 총정리

## 1. `static`의 개념

-   **정의**: 클래스 로더가 클래스 로딩 시점에 메모리에 올려두는 멤버.
    객체 생성 없이 접근 가능.
-   **특징**:
    -   모든 인스턴스가 공유
    -   JVM 시작 시 로딩, 종료 시 해제
    -   객체 상태(`this`)와 무관하게 동작

---

## 2. 적절한 사용 예시

``` java
public class MathUtil {
    private MathUtil() {} // 객체 생성 방지
    public static int add(int a, int b) {
        return a + b;
    }
}
```

➡️ 유틸리티 함수. 인스턴스 필요 없음.

``` java
public class Constants {
    public static final String APP_NAME = "MyApp";
}
```

➡️ 상수 정의. 공용 불변 값.

``` java
@Service
public class UserService {
    private static final Logger log = LoggerFactory.getLogger(UserService.class);
}
```

➡️ 로깅. 모든 인스턴스에서 동일 Logger 공유.

---

## 3. 부적절한 사용 예시

``` java
@Service
public class UserService {
    public static void save(User user) {
        // DB 저장 로직
    }
}
```

❌ 비즈니스 로직을 static으로 → DI, 테스트 불가.

``` java
public class DBConnection {
    public static Connection conn;
}
```

❌ 자원 관리 객체를 static으로 → Spring 컨테이너 관리 바깥, 라이프사이클
깨짐.

``` java
public class Counter {
    public static int count = 0;
}
```

❌ 공유 mutable state → 멀티스레드 환경에서 동시성 문제 발생.

---

## 4. Spring에서의 활용

-   ✅ **좋은 경우**
    -   상수 정의
    -   유틸성 함수
    -   로깅 (Logger)
    -   JUnit `@BeforeAll`
-   ❌ **피해야 할 경우**
    -   서비스/리포지토리 로직
    -   DB, API 클라이언트와 같은 자원
    -   상태 공유 필드

---

## 5. 실무 체크리스트

### ✅ 해야 한다

-   상수 (`static final`)
-   유틸성 메서드 (순수 기능)
-   로깅 필드

### ❌ 하면 안 된다

-   상태를 가지는 필드
-   비즈니스 로직
-   DI 받아야 하는 의존성 관리

---

## 📌 한 줄 요약

**static은 객체 상태와 무관한 도구(유틸, 상수, 로깅) 용도로만 쓰고,
나머지는 Spring 빈/DI로 관리하라.**
