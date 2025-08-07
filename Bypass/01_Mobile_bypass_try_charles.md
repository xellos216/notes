# 🧾 Charles proxy 우회 실험 정리

## 1. 🎯 목표
- **클라이언트 측 요청 분석 및 자동화**
- 타이머 기반 **출석 우회 시나리오** 확인
- HTTPS 트래픽을 **Charles Proxy** 등으로 분석하여 구조 파악

---

## 2. 🧰 실습 환경
| 항목 | 내용 |
|------|------|
| 디바이스 | iPhone + Windows PC |
| 분석 도구 | Charles Proxy 5.0.1 |
| 대상 도메인 | `nbcamp.spartacodingclub.kr` |
| 프록시 설정 | iPhone → Charles 연결 완료 |
| SSL 인증서 | iPhone에 **Charles Root CA** 직접 설치 및 신뢰 설정 완료 |

---

## 3. 🧪 시도한 내용 정리

| 항목 | 상태 | 비고 |
|------|------|------|
| ① Charles에 iPhone 연결 | ✅ 성공 | IP 연결 및 프록시 설정 완료 |
| ② Charles Root CA 설치 | ✅ 성공 | 설정 > 인증서 신뢰 설정 켬 |
| ③ `nbcamp.spartacodingclub.kr` SSL 프록싱 추가 | ✅ 성공 | Charles에 `443 포트`로 명시 |
| ④ 모바일 브라우저로 접속 | ❌ 실패 | `ERR_CONNECTION_CLOSED` or `connection lost` |
| ⑤ Charles 내 SSL 연결 확인 | ⚠️ 일부 연결, 다수 `PROTOCOL_ERROR(0x1)` 발생 | 서버에서 SSL reset함 (방어 장치 작동 중) |
| ⑥ Structure 뷰로 트래픽 분석 | ⚠️ 실패한 요청은 보이지만 구조적 리퀘스트 확인 어려움 | 패킷 분석 미흡 |

---

## 4. 🔐 현재 차단 메커니즘 추정

- 서버가 Charles와의 TLS 연결 중 `TLS fingerprint` 또는 `JA3 hash` 비교하여 **이상한 프록시 요청** 탐지
- 그 결과로 `PROTOCOL_ERROR (0x1)` 또는 `ERR_CONNECTION_CLOSED` 발생
- → **MITM 프록시 차단 장치**가 도입된 것으로 보임 (Cloudflare, Nginx 설정 가능)

---

## 5. 📌 현재 상태 요약

> **SSL 인증서 설치까지는 성공했지만**,  
> **대상 서버에서 의도적으로 TLS 프록시를 차단 중**이다.

---

# ✅ 다음 시도할 실험 
 `mitmproxy`로 HTTP/2 → HTTP/1.1 다운그레이드 | SSL reset 방지 

