# 자바에서 자주 쓰는 **이스케이프 문자 정리표**

| 코드   | 의미                  | 출력 예시       |
| ---- | ------------------- | ----------- |
| `\"` | 큰따옴표                | `"`         |
| `\'` | 작은따옴표               | `'`         |
| `\\` | 역슬래시                | `\`         |
| `\n` | 줄바꿈 (newline)       | 개행됨         |
| `\t` | 탭 (tab)             | (간격 띄움)     |
| `\r` | 캐리지 리턴 (줄 맨 앞으로 이동) | 잘 안 씀       |
| `\b` | 백스페이스               | 직전 글자 삭제 효과 |
| `\f` | 폼피드 (페이지 전환)        | 거의 안 씀      |

## 예시 코드

```java
public class EscapeDemo {
    public static void main(String[] args) {
        System.out.println("Hello\nWorld");   // 줄바꿈
        System.out.println("She said \"Hi\""); // 큰따옴표
        System.out.println("Path: C:\\temp\\"); // 역슬래시
        System.out.println("A\tB\tC"); // 탭 간격
    }
}
```

## 출력 결과

```
Hello
World
She said "Hi"
Path: C:\temp\
A   B   C
```
