# Docker & 웹 서버

## 1. Docker 설치와 컨테이너 개념

* **Docker**: 리눅스 커널을 공유하면서 격리된 실행 환경을 제공하는 컨테이너 엔진.
* **이미지**: 실행 템플릿.
* **컨테이너**: 이미지를 기반으로 실행된 격리된 프로세스.

**실습**

```bash
sudo pacman -S docker
sudo systemctl enable --now docker
sudo docker run hello-world
```

---

## 2. Ubuntu 컨테이너 실습

* 컨테이너 실행:

```bash
sudo docker run -it ubuntu bash
```

* 확인:

```bash
cat /etc/os-release
```

---

## 3. Flask 웹 서버 (Python)

* **Flask**: Python 경량 웹 프레임워크.

**구조**

```
flask-app/
 ├─ app.py
 ├─ requirements.txt
 └─ Dockerfile
```

**실행**

```bash
sudo docker build -t flask-app .
sudo docker run -d -p 5000:5000 --name flask1 flask-app
```

→ `http://localhost:5000` → `"Hello from Flask in Docker!"`.

---

## 4. Express 웹 서버 (Node.js)

* **Express**: Node.js 경량 웹 프레임워크.
* **주의**: `"type": "module"` 여부에 따라 `require`/`import` 선택.

**구조**

```
express-app/
 ├─ server.js
 ├─ package.json
 └─ Dockerfile
```

**실행**

```bash
sudo docker build -t express-app .
sudo docker run -d -p 3000:3000 --name express1 express-app
```

→ `http://localhost:3000` → `"Hello from Express in Docker!"`.
