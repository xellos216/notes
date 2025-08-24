## 문제
![](Question.png)

## 정답
![](Answer.png)

## Java
```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        
        System.out.print("나이를 입력하세요: ");
        int age = sc.nextInt();
        
        if (age >= 19) {
            System.out.println("성인");
        } else {
            System.out.println("미성년자");
        }
        
        sc. close();
    }
}
```
