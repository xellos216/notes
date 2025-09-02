# 클래스 변수와 인스턴스 변수의 차이점

## 1. 선언 위치와 키워드
- **클래스 변수**: `static` 키워드 붙음  
- **인스턴스 변수**: `static` 없음  

## 2. 소속
- **클래스 변수**: 클래스 자체에 속함. 모든 객체가 공유  
- **인스턴스 변수**: 각 객체에 속함. 객체마다 별도로 존재  

## 3. 메모리 생성 시점
- **클래스 변수**: 클래스가 메모리에 로드될 때 한 번만 생성  
- **인스턴스 변수**: 객체를 `new`로 만들 때마다 생성  

## 4. 접근 방법
- **클래스 변수**: `클래스명.변수명` 권장. 객체로도 접근은 가능하지만 권장하지 않음  
- **인스턴스 변수**: 반드시 객체 참조 변수를 통해 접근 (`obj.변수명`)  

## 5. 수명
- **클래스 변수**: 프로그램 종료까지 유지  
- **인스턴스 변수**: 객체가 GC(가비지 컬렉션)로 제거될 때 사라짐  

---

## 예시 코드

```java
class Example {
    static int classVar = 0;  // 클래스 변수
    int instanceVar = 0;      // 인스턴스 변수
}

public class Test {
    public static void main(String[] args) {
        Example e1 = new Example();
        Example e2 = new Example();

        e1.instanceVar = 10;
        e2.instanceVar = 20;
        Example.classVar = 100;

        System.out.println(e1.instanceVar); // 10 (e1만의 값)
        System.out.println(e2.instanceVar); // 20 (e2만의 값)
        System.out.println(Example.classVar); // 100 (모든 객체가 공유)
    }
}
```

### 출력 결과
```
10
20
100
```

---

## 결론
- 인스턴스 변수 → 객체마다 독립적
- 클래스 변수 → 모든 객체가 공유
