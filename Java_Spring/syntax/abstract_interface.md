# abstract vs interface 정리

## 1. 개념 설명
- **추상 클래스 (abstract class)**  
  - 객체를 직접 만들 수 없는 클래스.  
  - 공통 속성(필드)과 공통 동작(메서드)을 정의할 수 있다.  
  - 일부는 구현을 제공하고, 일부는 추상 메서드로 남겨 자식 클래스가 반드시 구현하도록 강제한다.  

- **인터페이스 (interface)**  
  - 클래스가 반드시 따라야 하는 규약(명세).  
  - 필드 대신 상수(`public static final`)만 가질 수 있고, 대부분 추상 메서드로 구성된다.  
  - 여러 인터페이스를 한 클래스가 동시에 구현할 수 있다(다중 상속 허용).  

---

## 2. 비유
- **추상 클래스**:  
  “건물 설계도 + 기초공사까지 해둔 상태.”  
  → 건물을 지을 때 공통 구조는 이미 만들어져 있고, 세부 마감은 자식 클래스가 채운다.  

- **인터페이스**:  
  “콘센트 규격.”  
  → 어떤 전자제품이든 이 규격에 맞춰야만 전기를 쓸 수 있다. 규격만 있고 내부 구현은 제품이 알아서 한다.  

---

## 3. 둘의 차이점

| 구분 | 추상 클래스 | 인터페이스 |
|------|-------------|-------------|
| **상속/구현** | `extends` → 한 클래스만 상속 가능 | `implements` → 여러 개 동시에 구현 가능 |
| **구성 요소** | 추상 메서드, 일반 메서드, 필드, 생성자 | 추상 메서드, (Java 8+) default 메서드, static 메서드, 상수 |
| **필드** | 인스턴스 변수 가질 수 있음 | 상수만 가능 |
| **생성자** | 가능 (`super()` 호출 가능) | 없음 |
| **목적** | 공통 속성과 동작을 일부 구현까지 제공 | 규격(명세)만 정의하여 구현 강제 |

---

## 4. 예시 코드

```java
// 추상 클래스
abstract class Animal {
    String name;                  // 필드
    Animal(String name) {         // 생성자
        this.name = name;
    }

    abstract void sound();        // 추상 메서드
    void sleep() {                // 일반 메서드
        System.out.println("zzz");
    }
}

// 인터페이스
interface Playable {
    void play();                  // 추상 메서드
    default void tune() {         // Java 8+ default 메서드
        System.out.println("Tuning...");
    }
}

// 구현 클래스
class Dog extends Animal implements Playable {
    Dog(String name) {
        super(name);
    }
    @Override
    void sound() {
        System.out.println("Woof");
    }
    @Override
    public void play() {
        System.out.println(name + " plays fetch");
    }
}
