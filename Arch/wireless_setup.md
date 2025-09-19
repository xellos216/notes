# Arch Wifi set up

##. 무선 패키지 설치(권장: NetworkManager)

```bash
sudo pacman -Syu networkmanager iw wpa_supplicant wireless_tools dialog
sudo systemctl enable --now NetworkManager
```

##. 무선 인터페이스 확인

```bash
ip link           # 인터페이스 이름 확인 (예: wlan0, wlp3s0)
nmcli device      # NetworkManager 장치 상태 확인
```

##. 주변 AP 스캔 및 연결 (CLI)

```bash
### AP 목록
nmcli device wifi list

### 연결 (예)
nmcli device wifi connect "SSID" password "비밀번호"
# 연결이 성공하면 자동으로 IP/DHCP 받음
```

(대체: `nmtui` 로 TUI 사용 가능)

##. 연결 확인 및 네트워크 범위 파악

```bash
## 할당된 IP와 서브넷(CIDR) 확인
ip -o -f inet addr show dev <무선인터페이스> | awk '{print $4}'
## 기본 게이트웨이 확인
ip route | grep default
```

예: 결과가 `192.168.1.42/24` 이면 네트워크 범위는 `192.168.1.0/24`.

##. 같은 LAN의 장비만 스캔 (안전)

```bash
# 호스트 발견(핑 스캔)
nmap -sn 192.168.1.0/24

# 특정 IP의 서비스 확인 (포트/버전)
nmap -sV -p 1-1024 192.168.1.1
```

##. 같은 물리 LAN(같은 L2) 장비만 빠르게 확인

```bash
ip neigh show    # ARP 테이블로 같은 서브넷의 장치 확인
arp -n
```

##. 라우터(DHCP)에서 내부 장비 목록 확인 (권장)

* 웹브라우저로 기본 게이트웨이(예: `http://192.168.1.1`) 접속 → DHCP 클라이언트 목록 확인
* 이 방법이 내부 장치 확인에서 가장 정확하고 안전함

##. 주의사항(한 줄)

* 항상 네트워크 소유자 허가 → 과도한 스캔(대량 포트 스캔, 전체 공인블록 스캔)은 ISP/관리자에 문제를 일으킬 수 있음
