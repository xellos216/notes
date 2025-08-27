# this, super, 생성자, 상속 정리

## 1. 상속과 생성자 관계
- 자식 객체는 **부모 부분 + 자식 부분**이 합쳐져 하나로 생성된다.
- **부모 부분 초기화**는 반드시 부모 생성자가 수행한다.
- 따라서 자식 생성자가 실행되기 전에 **부모 생성자가 먼저 호출**된다.

---

## 2. this
- **의미**: 현재 객체 자기 자신.
- **용도**
  - `this.field` → 현재 객체의 필드 참조
  - `this.method()` → 현재 객체의 메서드 호출
  - `this(...)` → 같은 클래스 안의 다른 생성자 호출 (생성자 첫 줄에서만 가능)

---

## 3. super
- **의미**: 부모 객체(상위 클래스).
- **용도**
  - `super.field` → 부모 클래스의 필드 참조
  - `super.method()` → 부모 클래스의 메서드 호출
  - `super(...)` → 부모 생성자 호출 (생성자 첫 줄에서만 가능)

---

## 4. 생성자와 상속
- **생성자는 상속되지 않는다**.  
  → 자식이 부모의 생성자를 가져다 쓰는 것이 아님.
- 자식 생성자가 실행되면 반드시 부모 생성자가 먼저 실행되어야 한다.
- 자식 생성자에서 `super(...)`로 부모 생성자를 호출해야 한다.
- 만약 `super(...)`가 없으면 컴파일러가 자동으로 `super();`(부모 기본 생성자) 삽입한다.
- 부모에 기본 생성자가 없으면, 자식에서 `super(인자)`를 **명시적으로** 호출해야 한다.

---

## 5. 코드 예시

```java
class Animal {
    String name;

    // 부모 생성자
    Animal(String name) {
        System.out.println("Animal constructor");
        this.name = name;
    }
}

class Dog extends Animal {
    // 자식 생성자
    Dog(String name) {
        super(name); // 부모 생성자 호출
        System.out.println("Dog constructor");
    }
}

public class Main {
    public static void main(String[] args) {
        Dog dog = new Dog("Charlie");
        System.out.println(dog.name);
    }
}
````

### 실행 결과

```
Animal constructor
Dog constructor
Charlie
```

---

## 6. 핵심 요약

1. **this** = 자기 자신, `this(...)`는 같은 클래스의 다른 생성자 호출.
2. **super** = 부모 객체, `super(...)`는 부모 생성자 호출.
3. **생성자는 상속되지 않는다.**
4. 자식 객체를 만들 때 부모 생성자가 반드시 먼저 실행된다.
