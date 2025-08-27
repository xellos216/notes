# tmux 사용 가이드

## 1. tmux란?
- **Terminal Multiplexer**
- 하나의 터미널 안에서 여러 **윈도우(탭)**와 **패널(분할 화면)** 관리 가능
- 세션을 분리(detach)해도 백그라운드에서 계속 실행됨 → SSH 끊겨도 프로세스 유지
- CLI 환경에서 멀티태스킹을 극대화하는 도구

---

## 2. 설치
Ubuntu 기준:
```bash
sudo apt update
sudo apt install tmux
````

버전 확인:

```bash
tmux -V
```

---

## 3. 기본 개념

* **세션(Session)**: 최상위 단위. 여러 창과 분할을 묶음
* **윈도우(Window)**: 세션 안의 "탭"
* **패널(Pane)**: 윈도우를 수직·수평 분할한 화면

---

## 4. 세션 관리

```bash
tmux new -s mysession      # 세션 생성
tmux ls                    # 세션 목록
tmux attach -t mysession   # 세션 접속
tmux detach                # 세션 분리 (Ctrl+b d와 동일)
tmux kill-session -t mysession  # 세션 종료
```

---

## 5. 기본 단축키

tmux 명령은 기본적으로 \*\*Prefix (Ctrl+b)\*\*를 먼저 누른 뒤 동작키를 입력한다.

| 동작     | 키 입력                                          |
| ------ | --------------------------------------------- |
| 새 윈도우  | `Ctrl+b c`                                    |
| 윈도우 전환 | `Ctrl+b n` (다음), `Ctrl+b p` (이전), `Ctrl+b 숫자` |
| 윈도우 목록 | `Ctrl+b w`                                    |
| 가로 분할  | `Ctrl+b "`                                    |
| 세로 분할  | `Ctrl+b %`                                    |
| 패널 전환  | `Ctrl+b 방향키`                                  |
| 패널 닫기  | 패널 안에서 `exit`                                 |
| 세션 분리  | `Ctrl+b d`                                    |
| 스크롤 모드 | `Ctrl+b [` (종료: q)                            |

---

## 6. 사용 예시

```bash
tmux new -s work     # work라는 세션 시작
Ctrl+b "             # 화면 가로 분할
Ctrl+b %             # 화면 세로 분할
Ctrl+b n             # 새 윈도우 생성
Ctrl+b d             # 세션 분리 (백그라운드 유지)
tmux attach -t work  # 다시 접속
```

---

## 7. 학습 루트

1. **세션** 만들기/붙기/분리
2. **윈도우** 생성과 이동
3. **패널** 분할과 이동
