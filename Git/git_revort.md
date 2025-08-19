# Git 브랜치 롤백 작업 순서

## 상황
- `feat/hongmin` 브랜치를 잘못 `main`에 병합함.
- 원래는 `dev`에 병합해야 했음.
- 이미 팀원이 `dev`로 정상 병합했으므로, `main`에서만 해당 머지를 되돌림.

---

## 작업 순서

1. **원격 `main` 브랜치 로컬에 가져오기**
   ```bash
   git config remote.origin.fetch +refs/heads/*:refs/remotes/origin/*
   git fetch origin
   git checkout -b main origin/main
````

2. **문제의 머지 커밋 해시 확인**

   ```bash
   git log --oneline
   ```

   예: `abdcc30 Merge pull request #3 from wecandoitoctopus/feat/hongmin`

3. **머지 커밋 되돌리기**

   ```bash
   git revert -m 1 abdcc30
   ```

   * `-m 1` : 머지 시 부모 브랜치를 지정 (`main`을 기준으로 되돌리기)

4. **커밋 메시지 저장**

   * 편집기(nano)에서 `Ctrl+O`, `Enter`, `Ctrl+X`로 저장 및 종료.

5. **원격 `main`에 푸시**

   ```bash
   git push origin main
   ```

---

## 결과

* `main` 브랜치에서 잘못된 머지 커밋이 되돌려짐.
* `dev`에는 영향 없음.
* 앞으로 `main → dev` 머지는 금지, `dev → main` 방향만 유지.
