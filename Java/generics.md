## 1) 개념 (Theory)  
- **제네릭(Generics)**: 클래스, 인터페이스, 메서드가 다룰 데이터 **타입을 매개변수처럼 일반화**해 두고, 실제 사용할 때 타입을 지정하는 문법.  
- **등장 이유**  
  - 타입 안정성: 잘못된 타입 삽입을 컴파일 단계에서 차단.  
  - 형변환 제거: 꺼낼 때 별도 캐스팅 불필요.  
  - 코드 재사용: 같은 코드로 다양한 타입을 처리 가능.  
- **동작 원리**  
  - 컴파일 시 타입 체크 → 런타임에는 타입 소거(Type Erasure)로 일반 클래스처럼 동작.  

---

## 2) 비유 (Analogy)  
- **택배 상자 설계도**:  
  - 상자(Box)를 설계할 때는 “어떤 물건을 넣을지” 정하지 않는다.  
  - 실제 주문할 때 “책 전용 Box<String>”, “사과 전용 Box<Apple>”로 정한다.  
  - 잘못된 물건을 넣으면 택배사가 거부한다(컴파일 에러).  

---

## 3) 예시 코드 (Example Code)  

### 제네릭 없는 경우  
```java
List list = new ArrayList();  // 타입 미지정
list.add("Hello");
list.add(123);                 // 다른 타입도 들어감

String s = (String) list.get(0); // 형변환 필요
Integer n = (Integer) list.get(1);
```
→ 여러 타입이 섞일 수 있고, 캐스팅 오류 위험.  

### 제네릭 사용하는 경우  
```java
List<String> list = new ArrayList<>();
list.add("Hello");
// list.add(123);  // 컴파일 에러 발생

String s = list.get(0);        // 캐스팅 불필요
```

### 제네릭 클래스 정의  
```java
class Box<T> {
    private T value;
    public void set(T value) { this.value = value; }
    public T get() { return value; }
}

Box<String> b1 = new Box<>();
b1.set("Hello");
String s = b1.get();           // String 반환
```

---

## 4) 주요 문법  
- `<>` : **다이아몬드 연산자**. 객체 생성 시 타입 추론.  
- `<T>` : **타입 매개변수**. 제네릭 클래스·메서드 정의에 사용.  
- `<?>` : **와일드카드**. 제한 없는 임의 타입. (읽기 전용)  
- `<? extends T>` : **상한 제한**. T 또는 하위 타입만 허용. (읽기 OK, 쓰기 제한)  
- `<? super T>` : **하한 제한**. T 또는 상위 타입만 허용. (쓰기 OK, 읽기 Object)  

---

## 5) 최종 요약  
- 제네릭은 **타입 안정성과 재사용성을 동시에 확보**하는 도구.  
- 정의 단계에서는 타입을 비워두고(`Box<T>`),  
- 사용 단계에서 타입을 확정(`Box<String>`, `Box<Integer>`).  
- 실무에서는 `List<T>`, `Map<K,V>`, DTO 변환, 범용 유틸리티 메서드에서 필수적으로 쓰인다.  

---

👉 정리하면: **제네릭은 타입을 변수처럼 받아, 같은 코드로 다양한 타입을 안전하게 다룰 수 있게 해주는 문법**이다.  
