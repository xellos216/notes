# oil.nvim 핵심 명령어

## 기본 탐색

| 키 | 기능 |
|---|---|
| `-` | 현재 파일의 부모 디렉토리를 Oil로 열기 |
| `<CR>` | 파일 열기 / 디렉토리 들어가기 |
| `..` | 상위 디렉토리 |
| `g.` | 숨김 파일 토글 |
| `R` | 디렉토리 새로고침 |

---

## 파일 생성

1. `o`
2. 파일 이름 입력
3. `:w`

예

new_file.py

폴더 생성

new_folder/

---

## 파일 이름 변경

파일 이름을 직접 수정 후

`:w`

예

old_name.py → new_name.py

---

## 파일 이동

경로를 수정

예

models/user.py

↓

models/domain/user.py

저장하면 실제로 이동된다.

---

## 파일 삭제

라인 삭제

dd

저장

:w

---

## 여러 파일 동시에 작업

여러 줄 수정 가능

예

```

test_user.py
test_model.py
test_dataset.py

```

visual block 또는 multi-edit 가능

---

## split 열기

| 키 | 기능 |
|---|---|
| `<CR>` | 현재 창 |
| `<C-s>` | horizontal split |
| `<C-v>` | vertical split |

---

## 변경사항 적용

| 명령 | 기능 |
|---|---|
| `:w` | 파일 시스템에 반영 |
| `:q` | 변경 취소 |
