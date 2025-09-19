# Libvirt / QEMU / KVM 치트시트 (Arch 기준)

## 기본 개념

* **KVM (Kernel-based Virtual Machine)**

  * 리눅스 커널이 제공하는 하이퍼바이저 기능.
  * CPU의 가상화 확장(Intel VT-x/AMD-V)을 사용해서 하드웨어 가상화를 제공.
  * "가상화 엔진" 역할을 한다.

* **QEMU**

  * 범용 에뮬레이터/가상화 툴.
  * KVM과 결합하면 “에뮬레이션”이 아니라 “가속된 가상화”가 된다.
  * VM을 실제로 실행시키는 백엔드.

* **Libvirt**

  * VM 관리용 추상화 계층.
  * 다양한 하이퍼바이저(QEMU/KVM, Xen, VirtualBox 등)를 공통 인터페이스로 제어 가능.
  * `virsh`, `virt-manager`, `virt-install` 같은 툴이 libvirt API를 사용한다.

* **도구별 역할**

  * `virsh`: CLI 기반 libvirt 관리 툴.
  * `virt-manager`: GUI 기반 libvirt 관리 툴.
  * `virt-install`: 새로운 VM을 만드는 CLI 툴.
  * `virt-viewer`: 특정 VM 화면만 열어주는 뷰어.

---

## VM 생성

* 새 VM 생성 (설치할 때만 1회 실행)

```bash
sudo virt-install \
  --name kali-lab \
  --ram 4096 --vcpus 2 \
  --disk path=/var/lib/libvirt/images/kali-lab.qcow2,size=20 \
  --os-variant debian11 \
  --cdrom /var/lib/libvirt/images/kali-linux-*.iso \
  --network network=default \
  --graphics spice
```

---

## VM 관리 (virsh)

* VM 목록 확인

```bash
virsh -c qemu:///system list --all
```

* VM 시작

```bash
virsh -c qemu:///system start kali-lab
```

* VM 정상 종료 (게스트 OS에 shutdown 요청)

```bash
virsh -c qemu:///system shutdown kali-lab
```

* VM 강제 종료 (전원 끄기)

```bash
virsh -c qemu:///system destroy kali-lab
```

* VM 재부팅

```bash
virsh -c qemu:///system reboot kali-lab
```

* VM 자동 시작 설정 (호스트 부팅 시 함께 켜짐)

```bash
virsh -c qemu:///system autostart kali-lab
```

* VM 자동 시작 해제

```bash
virsh -c qemu:///system autostart --disable kali-lab
```

---

## VM 화면 열기

* GUI 관리 툴

```bash
virt-manager
```

* 단독 뷰어

```bash
virt-viewer --connect qemu:///system kali-lab
```

* 텍스트 콘솔 접속

```bash
virsh -c qemu:///system console kali-lab
# 빠져나오기: Ctrl + ]
```

---

## 스냅샷 관리

* 스냅샷 생성

```bash
virsh -c qemu:///system snapshot-create-as kali-lab "init" "Initial snapshot"
```

* 스냅샷 목록

```bash
virsh -c qemu:///system snapshot-list kali-lab
```

* 스냅샷 되돌리기

```bash
virsh -c qemu:///system snapshot-revert kali-lab --snapshotname init
```

---

## 네트워크 관리

* 네트워크 목록

```bash
virsh -c qemu:///system net-list --all
```

* 기본(default) 네트워크 시작/자동시작

```bash
sudo virsh net-start default
sudo virsh net-autostart default
```

알겠다. Arch 호스트에서 Kali XFCE VM을 GUI까지 깔끔하게 쓰는 방법을 정리해준다.

---

# Arch + Libvirt + virt-manager 환경가이드

## 1. 접근 방식 요약

* **virsh console**
  텍스트 전용. 비상 시나 서버 VM에 적합. GUI 없음.
* **virt-viewer / virt-manager**
  그래픽 콘솔. Kali XFCE 같은 데스크탑 배포판을 일반 PC처럼 사용 가능.

---

## 2. VM 실행과 접속

* VM 시작

```bash
virsh -c qemu:///system start kali-lab
```

* VM GUI 접속 (추천)

```bash
virt-manager
```

→ VM 목록에서 `kali-lab` 더블클릭하면 창이 뜬다.

* 또는 단독 뷰어:

```bash
virt-viewer --connect qemu:///system kali-lab
```

---

## 3. 편의 기능 설정

### 디스플레이 (화면)

* 기본은 **Spice** 프로토콜.
* virt-manager → VM 설정 → **디스플레이 Spice** 로 확인.
* 해상도 변경은 VM 내부 XFCE 설정에서 가능.

### 마우스/키보드 통합

* virt-manager가 자동 처리.
* 창 안팎 마우스 커서 전환도 자연스럽다.

### 클립보드 공유

* virt-manager에서 VM 설정 → **채널(Channel)** → `Spice agent` 추가.
* Kali VM 내부에서 `spice-vdagent` 설치:

```bash
sudo apt install spice-vdagent
```

→ 이후 호스트와 게스트 간 **Ctrl+C / Ctrl+V** 가능.

### 파일 공유 (드래그 앤 드롭 / 폴더 마운트)

* 간단: virt-manager → “파일 시스템” 장치 추가 → 타입 `mount`, 경로 `/home/h/shared` 같은 디렉터리 지정.
* Kali 내부에서 `/media` 같은 경로로 접근 가능.
* 패키지 필요시:

```bash
sudo apt install spice-webdavd
```

### 사운드

* virt-manager → “사운드” 장치 추가.
* Spice 드라이버 통해 오디오 출력 가능.

---

## 4. 스냅샷 & 롤백

* 설치 직후 스냅샷:

```bash
virsh -c qemu:///system snapshot-create-as kali-lab "clean" "Fresh install"
```

* 문제 생기면 롤백:

```bash
virsh -c qemu:///system snapshot-revert kali-lab --snapshotname clean
```

---

## 5. 네트워크

* NAT(default): VM에서 인터넷만 가능, 외부에서 접근 불가. (안전)
* Host-only: 호스트와만 통신.
* Bridge: VM이 호스트와 같은 네트워크에 직접 붙음 (보안 주의).

---

## 6. 정리

* **CLI VM** → virsh console, SSH.
* **데스크탑 VM (Kali XFCE)** → virt-manager GUI 창.
* 클립보드/파일공유는 spice-vdagent, spice-webdavd 설치.
* 스냅샷 적극 활용해 문제 생기면 쉽게 롤백.
