# 서버 실행 및 백그라운드 관리 명령어 정리

| 구분 | 명령어 | 설명 |
|------|--------|------|
| 실행 | `./gradlew bootRun` | Spring Boot 서버 실행 (포어그라운드) |
| 일시정지 | `Ctrl + Z` | 실행 중 프로세스 일시정지 후 백그라운드로 이동 (Stopped 상태) |
| 백그라운드 실행 | `bg %1` | 멈춘 job(`%1`)을 백그라운드 실행 (Running 상태) |
| 포어그라운드 복귀 | `fg %1` | 해당 job을 포어그라운드로 가져오기 |
| 종료(앞단) | `Ctrl + C` | 포어그라운드 실행 중 프로세스 종료 |
| 종료(뒤단) | `kill %1` | jobs에서 확인한 job 번호(`%1`) 프로세스 종료 |
| 종료(PID) | `ps aux \| grep bootRun` → `kill <PID>` | 실행 중인 PID 직접 확인 후 종료 |
| 상태 확인 | `jobs` | 현재 쉘 세션의 job 상태 확인 (Stopped/Running 표시) |
| 장기 실행(로그 저장) | `nohup ./gradlew bootRun > server.log 2>&1 &` | 터미널 닫아도 실행 유지, 로그는 server.log에 저장 |
| 장기 실행(세션 유지) | `tmux` / `screen` | 별도 세션에서 실행, 접속 종료 후 재접속 가능 |

