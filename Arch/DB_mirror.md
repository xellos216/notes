````markdown
# Arch Linux pacman 미러 동기화 오류 (404)

## 개념 설명
Arch Linux의 패키지 관리자는 `pacman`이고, 패키지 저장소는 **미러 서버**(mirror)에서 동작한다.  
`pacman`은 크게 두 가지 데이터를 사용한다:

1. **패키지 데이터베이스(DB)**  
   - 각 저장소(`core`, `extra`, `community` 등)에 어떤 패키지가, 어떤 버전으로 있는지 기록한 목록.  
   - 예: `python-setuptools-1:80.9.0-2` 버전 존재.

2. **패키지 파일(.pkg.tar.zst)**  
   - 실제 설치되는 압축 파일.  
   - DB에서 명시된 버전과 파일명이 일치해야 다운로드 가능.

문제는 **미러 서버가 DB와 패키지 파일을 동시에 갱신하지 않는다**는 점이다.  
- DB가 먼저 갱신되고 파일이 늦게 올라오면, `pacman`은 최신 버전 정보를 받아왔지만 실제 파일은 아직 없음 → `404 Not Found`.  
- 반대로 파일이 먼저 올라오고 DB가 늦게 갱신되면, `pacman`은 아직 이전 버전만 인식.

이를 "DB와 패키지 파일이 서로 다른 시점(out of sync)"이라고 부른다.

---

## 원인
- 특정 미러 서버가 동기화 도중이라 DB만 최신 상태고 파일은 아직 복제되지 않음.
- 전 세계에 퍼져 있는 미러는 일정 주기로 rsync 동기화를 하기 때문에, 짧게는 몇 분~몇 시간 동안 이런 불일치가 발생할 수 있음.

---

## 해결 방법
1. **DB 강제 새로고침**
   ```bash
   sudo pacman -Syy
````

* 로컬 DB를 무조건 다시 내려받아 최신 상태로 맞춤.

2. **업데이트 재시도**

   ```bash
   sudo pacman -Syu
   ```

3. **미러 교체**

   * 특정 미러가 자주 404를 뱉으면 다른 미러로 바꾼다.

   ```bash
   sudo pacman -S reflector
   sudo reflector --country 'South Korea,Japan' --protocol https \
     --latest 15 --sort rate --save /etc/pacman.d/mirrorlist
   sudo pacman -Syyu
   ```

4. **캐시 정리 후 재시도 (꼬였을 때)**

   ```bash
   sudo pacman -Scc   # 캐시 전체 삭제
   sudo pacman -Syyu
   ```

---

## 정리

* `pacman`은 DB와 패키지 파일이 일치해야 설치 가능.
* 미러 서버가 동기화 중이면 DB와 파일이 일시적으로 어긋나 `404` 오류 발생.
* 해결책은 DB 강제 갱신 → 그래도 안 되면 더 잘 동기화된 미러로 교체.
* Arch Linux 특성상 이런 현상은 가끔 발생하며, pacman 자체 문제는 아님.

```

