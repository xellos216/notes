# tar 명령어로 프로젝트 압축하기 (Git 제외)

프로젝트를 공유하거나 코드 리뷰를 위해 업로드할 때는  
`.git`, `venv`, `outputs` 같은 불필요한 파일을 제외하고 압축하는 것이 좋다.

Linux에서는 `tar` 명령어를 사용해 쉽게 압축할 수 있다.

---

# 프로젝트 압축 명령어

프로젝트 루트 디렉토리에서 다음 명령어를 실행한다.

```bash
tar -czf cv-dataset-automation-toolkit.tar.gz \
--exclude=.git \
--exclude=venv \
--exclude=outputs \
--exclude=quarantine \
--exclude=__pycache__ \
.
