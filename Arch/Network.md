# 네트워크 개념 정리

---

## 1. 네트워크 기초
- **IP / Subnet / CIDR**  
  - IP는 호스트 식별자, 서브넷은 네트워크 경계.  
  - CIDR 표기(`192.168.1.0/24`)로 네트워크 범위 표현.  
  - 실습: `ip addr`, `ip route`, `ipcalc`  
- **MAC / ARP**  
  - MAC: L2 식별자.  
  - ARP: IP↔MAC 매핑 프로토콜. ARP 스푸핑으로 MITM 가능.  
  - 실습: `arp -n`, `arping`  
- **Router / Switch / Gateway**  
  - Router: 네트워크 간 패킷 전달.  
  - Switch: LAN 내부 장치 연결.  
  - Gateway: 네트워크 경계 장치.  
- **NAT**  
  - 사설 IP ↔ 공인 IP 변환. 포트포워딩이 공격 표적.  
  - 실습: NAT 네트워크에서 포트포워딩 적용.

---

## 2. 핵심 프로토콜
- **DHCP**: 클라이언트에 IP·게이트웨이·DNS 자동 배포.  
- **DNS**: 도메인 ↔ IP 변환. 캐시 포이즈닝 가능.  
- **ICMP**: 진단용 프로토콜. Ping flood, Smurf 공격 사례.  
- **TCP / UDP**: 연결지향 vs 비연결. 세션 하이재킹·UDP Flood 취약점.  
- **HTTP / TLS**: 웹 표준. TLS 인증서 검증 실패 시 MITM 공격 가능.

---

## 3. 스캐닝·탐지
- **포트 스캔**: SYN 스캔, UDP 스캔, OS 지문 식별.  
  - 실습: `nmap -sS -sV -O <target>`  
- **정보 수집**  
  - 패시브: 로그·DNS 조회. 흔적 없음.  
  - 액티브: 스캔·배너그랩. 탐지 흔적 남음.

---

## 4. 패킷 분석·조작
- **캡처**: `tcpdump`, `wireshark`로 프로토콜 흐름 분석.  
- **조작**: `scapy`, `hping3`, `netcat`으로 패킷 생성·전송.  
- **활용**: SYN flood, ICMP tunneling, MITM 실험.

---

## 5. 인증·암호화
- **대칭 vs 비대칭**: 대칭은 빠르지만 키 관리가 어렵다. 비대칭은 느리지만 키 교환·서명 가능.  
- **TLS/PKI**: 인증서, CA, 체인 구조. HTTPS 안전성 핵심.  
- **SSH**: 공개키 기반 인증 권장. 키 관리 실패는 치명적.

---

## 6. 공격 기법
- **MITM**: ARP 스푸핑, DNS 스푸핑, HTTPS 미적용 서비스 가로채기.  
- **권한 상승**: SUID, cron, 커널 취약점.  
- **셸 기법**: 리버스 셸, 바인드 셸. 방화벽 우회에 사용.  
- **피벗팅 / 터널링**: SSH 포트포워딩, proxychains. 내부망 확장.  
- **C2 개념**: 공격자가 원격으로 지속적 제어.

---

## 7. 방어·탐지
- **IDS/IPS**: Suricata, Snort. 패킷 룰 기반 탐지.  
- **방화벽**: iptables, nftables. 최소 권한 원칙 적용.  
- **DNSSEC, HSTS, CSP**: DNS 변조, HTTPS 강제, 웹 취약 완화.  
- **패치 관리**: CVE 추적 및 최신화.

---

## 8. 운영체제·로컬 보안
- **파일 권한 / SUID**: 잘못된 권한은 권한상승 통로.  
  - `find / -perm -4000 2>/dev/null`  
- **커널 취약점**: 익스플로잇으로 루트 탈취 가능.  
- **컨테이너 보안**: 네임스페이스·cgroups. 탈출 위험 존재.

---

## 9. 웹 공격 벡터
- **XSS, CSRF, SQLi**: 입력 검증 실패.  
- **세션 관리**: 안전한 쿠키(`HttpOnly`, `Secure`, `SameSite`).  
- **실습**: DVWA, Juice Shop 등 취약 앱 사용.

---

## 10. 고급 인프라
- **BGP**: AS 간 라우팅. BGP 하이재킹은 대규모 트래픽 전환.  
- **DNS Tunneling**: 데이터 은닉 전송 가능. dnscat2로 실습.

---

## 11. 필수 도구
- **정보수집**: nmap, masscan  
- **패킷**: tcpdump, wireshark, tshark  
- **조작/셸**: netcat, socat, scapy, hping3  
- **MITM/프록시**: mitmproxy, bettercap  
- **해시/암호**: john, hashcat  
- **익스플로잇**: metasploit, exploit-db  
- **탐지/방어**: suricata, snort, nftables

---

## 12. 실습 환경 지침
- 격리된 VM 네트워크 (NAT, Host-only).  
- KVM/QEMU + libvirt + virt-manager 권장 (Arch 기준).  
- VM 스냅샷·롤백 필수.  
- 로그·캡처 저장 후 분석.

---

## 13. 권장 실습 루트
1. 네트워크 기본 명령 (`ip`, `ss`, `route`, `arp`).  
2. 패킷 캡처 → wireshark 분석.  
3. nmap 포트·서비스 스캔.  
4. 격리망에서 MITM 시연.  
5. 취약 VM에서 권한 상승 실습.  
6. Suricata로 탐지 룰 작성.  
7. DVWA/Juice Shop으로 웹 취약성 실습.  
8. 피벗팅·터널링·DNS Tunneling 고급 주제.

---

## 14. 빠른 명령어 예시
```bash
# 네트워크 확인
ip addr
ip route
ss -tuln

# 패킷 캡처
sudo tcpdump -i eth0 -w cap.pcap

# 포트 스캔
nmap -sS -sV -O 192.168.1.0/24

# 리버스 셸 테스트 (격리망)
nc -lvp 4444

# SUID 탐색
find / -perm -4000 2>/dev/null
