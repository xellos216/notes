# 용도

* 네트워크 호스트의 포트 열림 여부를 병렬로 검사하고 배너·추정 서비스명을 수집해 CSV로 저장하는 CLI 도구.

# 사용한 라이브러리 (표준 라이브러리)

* `argparse` : CLI 인자 파싱
* `socket` : TCP 연결·배너 수집
* `concurrent.futures.ThreadPoolExecutor` : 병렬 스캔
* `csv` : 안전한 CSV 출력
* `datetime` : 소요 시간 계산
* `os` : CPU 수 조회(작업자 상한 계산)

# 주요 기능·구성

* CLI 인자: `--target/-t`, `--ports/-p`, `--timeout`, `--workers`, `--out`
* 포트 파싱: `parse_ports()` — 콤마·범위(`1-1024`) 지원, 화이트스페이스 무시, 1..65535 검증
* 연결 방식: `socket.create_connection((host,port), timeout)`로 일관된 타임아웃/예외 처리
* 배너 수집: 연결 후 `recv(1024)`로 초기 배너 읽기(가능하면)
* 서비스 식별: 포트 우선 매핑 + 배너 키워드 매칭(`identify_service`)으로 간단 추정
* 동시성 제어: `ThreadPoolExecutor(max_workers=clamp_workers(args.workers))` — FD 과다 사용 방지 위한 상한 적용
* 출력: 콘솔 로그 + CSV(`target,port,service,banner`)로 안전 저장
* 안전 처리: `KeyboardInterrupt` 처리, worker 예외 로깅, 파일 쓰기 예외 처리

# 주요 문법

* `with socket.create_connection(...) as s:` : 소켓 자동 close
* `ThreadPoolExecutor` + `as_completed()` : 작업 완료 순서 처리
* f-string 사용 (`f"[+] {target}:{port} open"`)
* CSV 쓰기 `csv.writer`로 필드 이스케이프 자동 처리
* `try/except/finally`로 리소스·예외 안전성 보장

# 제작 이유 

* 학습 목적: `nmap` 같은 고급 툴 내부 동작(소켓, 타임아웃, 배너) 이해
* 제어권: 병렬도·타임아웃·출력 포맷을 직접 제어해 실험 가능
* 경량화된 자동화: 특정 환경(홈 네트워크)에서 빠르게 통합·확장하기 쉬움
* 확장성: 배너 기반 식별, 추가 플러그인(HTTP 헤더 파싱 등) 삽입이 쉬움

# 짧은 사용 예

```bash
python3 postscan.py -t 192.168.0.232 -p 22,80,443 --timeout 0.5 --workers 50 --out result.csv
```

# 주의사항

* 반드시 소유·허가된 네트워크에서만 사용.
* `--workers` 과도 설정 시 라우터·호스트에 부하. 기본 상한이 적용되지만 주의 요망.
