# zoxide + fzf Quick Guide

## 1. zoxide

:contentReference[oaicite:0]{index=0}

### 개념

`zoxide`는 기존 `cd` 명령을 대체하는 **스마트 디렉터리 이동 도구**이다.  
사용자가 방문한 디렉터리를 기록하고 **방문 빈도와 최근 방문 시간**을 기반으로 가장 가능성이 높은 경로로 이동한다.

즉 긴 경로를 직접 입력할 필요 없이 **키워드만으로 디렉터리 이동**이 가능하다.

예

```
cd ~/projects/computer-vision/dataset-pipeline
```

↓

```
z pipeline
```

---

### 설치 (Arch Linux)

```
sudo pacman -S zoxide
```

---

### zsh 설정

`~/.zshrc`

```
eval "$(zoxide init zsh)"
```

적용

```
source ~/.zshrc
```

---

### 기본 사용법

#### 디렉터리 이동

```
z keyword
```

예

```
z pipeline
z yolo
z project
```

---

#### 후보 목록 확인

```
zoxide query -l
```

출력 예

```
45.0  ~/projects/dataset-pipeline
32.1  ~/projects/yolo-viewer
12.5  ~/Downloads
```

숫자는 **score**이며 다음 기준으로 계산된다.

- 방문 빈도 (frequency)
- 최근 방문 시간 (recency)

---

#### 특정 키워드 후보 확인

```
zoxide query -l keyword
```

예

```
zoxide query -l cv
```

---

#### 인터랙티브 선택

```
zi keyword
```

여러 후보가 있을 때 **선택 UI**가 열린다.

예

```
zi cv
```

---

### 일반적인 사용 패턴

예를 들어 프로젝트 구조가 다음과 같을 때

```
~/projects
├─ dataset-toolkit
├─ dataset-pipeline
├─ yolo-viewer
└─ coco-inspector
```

다음과 같이 이동 가능

```
z pipe
z yolo
z coco
```

---

## 2. fzf

:contentReference[oaicite:1]{index=1}

### 개념

`fzf`는 CLI에서 사용하는 **fuzzy finder(부분 문자열 검색 도구)**이다.  

입력한 문자열을 기반으로 **유사한 후보를 실시간으로 검색하고 선택**할 수 있다.

예

```
git branch
```

↓

```
git branch | fzf
```

검색 UI에서 브랜치를 선택할 수 있다.

---

### 설치 (Arch Linux)

```
sudo pacman -S fzf
```

---

### 기본 사용법

#### 리스트에서 항목 선택

```
ls | fzf
```

파일 목록이 나오고 검색하면서 선택 가능.

---

#### 히스토리 검색

```
history | fzf
```

---

#### 파일 검색

```
find . | fzf
```

---

## 3. zoxide + fzf 조합

`zi` 명령은 내부적으로 **fzf를 사용하여 디렉터리 선택 UI**를 제공한다.

예

```
zi project
```

동작

1. zoxide가 후보 디렉터리 목록 생성
2. fzf가 선택 인터페이스 제공
3. 선택한 디렉터리로 이동

---

## 4. CLI 개발 환경에서의 활용 예

개발 환경 예

```
~/projects
├─ cv-dataset-pipeline
├─ cv-yolo-annotation-viewer
├─ cv-coco-annotation-viewer
└─ cv-dataset-automation-toolkit
```

이동

```
z pipeline
z yolo
z coco
```

또는

```
zi cv
```

선택 UI에서 프로젝트 선택.

---

## 5. 핵심 요약

| 도구 | 역할 |
|-----|-----|
| zoxide | 스마트 디렉터리 이동 |
| fzf | CLI fuzzy 검색 |
| zi | zoxide + fzf 인터랙티브 이동 |

---

## 참고

zoxide GitHub  
https://github.com/ajeetdsouza/zoxide

fzf GitHub  
https://github.com/junegunn/fzf
