# Telescope.nvim 사용법 정리

## 개요

Telescope는 Neovim에서 사용하는 **fuzzy finder 검색 플러그인**이다.

주요 기능

- 프로젝트 파일 검색
- 프로젝트 전체 텍스트 검색
- 열린 버퍼 검색
- Git 파일 검색
- 최근 파일 검색
- 도움말 / 키맵 검색

Telescope는 내부적으로 ripgrep 같은 빠른 검색 도구를 사용한다.

---

# 기본 개념

Telescope는 **Picker**라는 검색 인터페이스를 실행한다.

구조

Results 창
검색 결과 목록

Prompt 창
사용자가 입력하는 검색어

Preview 창
선택된 결과 미리보기 (옵션)

---

# 기본 명령

## 파일 검색

```

:Telescope find_files

```

프로젝트 내 파일 이름을 fuzzy 검색한다.

예

```

dataset

```

결과

```

analyzers/dataset_stats.py
tests/test_dataset_stats.py

```

---

## 프로젝트 전체 코드 검색

```

:Telescope live_grep

```

프로젝트 전체에서 문자열을 검색한다.

예

```

DatasetStats

```

결과

```

analyzers/dataset_stats.py:15
tests/test_dataset_stats.py:7

```

---

## 열린 버퍼 목록

```

:Telescope buffers

```

현재 열려 있는 파일 목록을 보여준다.

---

## 최근 파일 열기

```

:Telescope oldfiles

```

최근에 열었던 파일 목록을 보여준다.

---

## 도움말 검색

```

:Telescope help_tags

```

Neovim help 문서를 검색한다.

---

# Picker 내부 키맵

Telescope 창 안에서 사용하는 키

| 키 | 기능 |
|----|------|
| Enter | 선택한 항목 열기 |
| Ctrl+j | 아래 이동 |
| Ctrl+k | 위 이동 |
| Ctrl+v | vertical split |
| Ctrl+s | horizontal split |
| Ctrl+t | 새 탭에서 열기 |
| Esc | Telescope 종료 |

---

# 가장 많이 쓰는 명령

개발 중 가장 자주 사용하는 4개

```

:Telescope find_files
:Telescope live_grep
:Telescope buffers
:Telescope oldfiles

```

---

# 실제 개발 워크플로우

예: 프로젝트에서 특정 파일 찾기

1

```

:Telescope find_files

```

2

검색 입력

```

stats

```

3

결과 선택

```

dataset_stats.py

```

4

Enter

파일 열림

---

# CLI 개발 환경에서의 조합

일반적인 Neovim 개발 워크플로우

파일 탐색

Oil.nvim

파일 검색

Telescope

코드 이동

LSP

이 조합이 가장 많이 사용되는 패턴이다.
```

필요하면 다음도 설명할 수 있다.

* **Neovim 개발자가 실제로 쓰는 Telescope 단축키 Top 7**
* **Telescope + ripgrep 코드 검색 워크플로우**
* **Telescope 속도를 크게 올리는 fzf-native 설정**
