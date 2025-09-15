## 1. 파일/디렉토리 조작

* `pwd`
  현재 디렉토리의 **절대 경로**를 출력. 프로세스가 파일을 찾을 기준이 됨.

* `ls`
  디렉토리 내용 출력.

  * `ls -l` : 권한, 소유자, 크기, 수정 시각을 긴 형식으로.
  * `ls -a` : 숨김 파일(`.`으로 시작) 포함.
  * `ls -lh` : 크기를 KB/MB 단위로 읽기 쉽게 표시.
  * `ls -lt` : 최근 수정된 순서대로 정렬.

* `cd`
  디렉토리 이동. `cd ..`는 상위, `cd -`는 이전 디렉토리.

* `mkdir` / `rmdir`
  새 디렉토리 생성, 비어 있을 때만 삭제 가능.

* `cp`
  파일/디렉토리 복사.

  * `cp src dst` : 파일 복사.
  * `cp -r dir1 dir2` : 디렉토리 전체 복사.

* `mv`
  파일 이동 또는 이름 변경.

  * `mv old new` : 이름 변경.
  * `mv file dir/` : 다른 디렉토리로 이동.

* `rm`
  파일 삭제.

  * `rm file` : 파일만 삭제.
  * `rm -r dir` : 디렉토리와 내용 모두 삭제.
  * `rm -i` : 삭제 전 확인 질문.

---

## 2. 파일 내용 확인

* `cat file` : 파일 내용을 **연속 출력**. 작은 파일에 적합.
* `less file` : 큰 파일을 **스크롤하며 확인**, `q`로 종료.
* `head -n 20 file` : 처음 20줄 출력. 기본은 10줄.
* `tail -n 20 file` : 마지막 20줄 출력. `tail -f log`로 **실시간 로그 추적**.

---

## 3. 검색·처리

* `grep "pattern" file` : 줄 단위로 문자열 검색.

  * `grep -i` : 대소문자 무시.
  * `grep -r "word" dir/` : 디렉토리 안 파일 전체 검색.

* `cut -d',' -f2 file.csv`
  구분자(`,`)로 열 나눠서 두 번째 열만 출력.

* `sort file`
  줄 단위 정렬.

  * `sort -r` : 내림차순.
  * `sort -n` : 숫자 기준 정렬.

* `wc file`
  줄 수, 단어 수, 바이트 수를 함께 출력.

  * `wc -l` : 줄 수.
  * `wc -w` : 단어 수.
  * `wc -c` : 바이트 수.

---

## 4. 압축/해제

* `gzip file` → `file.gz` 생성. `gunzip file.gz`으로 해제.
* `tar -cvf archive.tar files...` : 파일 묶기.
* `tar -xvf archive.tar` : 풀기.
* `tar -tvf archive.tar` : 아카이브 내부 목록 확인.
* `tar -czvf archive.tar.gz dir/` : tar + gzip 압축.

---

## 5. 권한 관리

* 권한 구조: `r(4)`, `w(2)`, `x(1)` → 합산해서 숫자로 표현.

  * `chmod 755 file` : 소유자는 rwx(7), 그룹·기타는 r-x(5).
  * `chmod u+x file` : 소유자(user)에 실행 권한 추가.

* `chown user:group file`
  파일 소유자와 그룹 변경. root 권한 필요.

---

## 6. 시스템 상태 확인

* `ps aux` : 실행 중인 모든 프로세스.
* `top` : CPU, 메모리, load 평균 실시간 확인.
* `df -h` : 파일시스템별 디스크 사용량.
* `du -sh dir` : 특정 디렉토리 크기 합산.
* `free -h` : 전체 메모리, 사용 중, 캐시, 남은 용량.
* `uptime` : 시스템 가동 시간과 load average.

---

## 7. 스크립트 실행

* **Shebang (`#!/bin/bash`)**
  스크립트 첫 줄에 위치. 이 파일을 어떤 인터프리터로 실행할지 지정.
  `#!/bin/bash` → Bash로 실행.

* **실행 권한 부여**

  ```bash
  chmod +x script.sh
  ```

  파일에 실행 권한을 추가.

* **실행 방법**

  ```bash
  ./script.sh
  ```

---

## 8. 변수와 출력/입력

* **변수 선언**

  ```bash
  name="Arch User"   # = 앞뒤에 공백 금지
  ```

* **출력**

  ```bash
  echo $name
  echo "Hello, $name"
  ```

* **입력(read)**

  ```bash
  read var
  ```

  → 사용자 입력을 `var`에 저장.

* **옵션**

  * `-p "문구"` : 입력 전에 메시지 표시
  * `-r` : 백슬래시(`\`)를 이스케이프 문자로 처리하지 않고 그대로 입력

예:

```bash
read -r -p "이름: " name
```

---

## 9. 조건문 (if)

* 기본 구조:

  ```bash
  if [ 조건 ]; then
      명령
  else
      다른 명령
  fi
  ```

* **문자열 비교**

  ```bash
  if [ "$name" = "Arch" ]; then
      echo "Welcome Arch!"
  fi
  ```

* **숫자 비교** (`[ ]` 내부에서는 연산 불가, 전용 연산자 사용)

  * `-eq` : 같다
  * `-ne` : 다르다
  * `-gt` : 크다
  * `-lt` : 작다
  * `-ge` : 크거나 같다
  * `-le` : 작거나 같다

* **산술 비교**는 `(( ))` 사용 가능:

  ```bash
  if (( num % 2 == 0 )); then
      echo "짝수"
  fi
  ```

---

## 10. 반복문

* **for**

  ```bash
  for i in 1 2 3; do
      echo $i
  done

  for i in {1..5}; do
      echo $i
  done
  ```

* **while**

  ```bash
  count=1
  while [ $count -le 5 ]; do
      echo $count
      count=$((count+1))
  done
  ```

* 산술 조건은 `(( ))` 권장:

  ```bash
  while (( count >= 0 )); do
      echo $count
      ((count--))
  done
  ```

---

## 11. 함수

* **정의**

  ```bash
  greet() {
      echo "Hello, $1"
  }
  ```

* **호출**

  ```bash
  greet Arch
  greet Hong
  ```

* **위치 매개변수**

  * `$0` : 실행된 스크립트 이름
  * `$1`, `$2` … : 첫 번째, 두 번째 인자
  * `$@` : 모든 인자
  * `$#` : 인자 개수

---

## 12. 명령어 조합

* **파이프(|)**: 앞 출력 → 뒤 입력

  ```bash
  ls | grep ".sh"
  ```
* **명령어 치환(\$( ))**: 실행 결과를 변수에 저장하거나 문자열에 삽입

  ```bash
  count=$(ls | grep ".sh" | wc -l)
  echo "Number of .sh files: $count"
  ```
