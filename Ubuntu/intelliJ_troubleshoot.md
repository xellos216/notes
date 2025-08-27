# IntelliJ IDEA 실행 오류 정리

## 1. 원인
- 이전 IntelliJ 프로세스가 완전히 종료되지 않아 **디렉터리 락(lock)** 또는 **Unix 소켓**이 계속 점유됨  
- 오류 메시지: `Address already in use`, `CannotActivateException`  
- 결과적으로 새 인스턴스가 기존 락/소켓 때문에 실행되지 못함

## 2. 해결 방법
1. **프로세스 종료**
   ```bash
   pgrep -fa idea
   pkill -9 -f idea
````

2. **남은 락/소켓 제거**

   ```bash
   rm -f "$XDG_RUNTIME_DIR/app/com.jetbrains.IntelliJ-IDEA-Ultimate/"*
   find ~/.var/app/com.jetbrains.IntelliJ-IDEA-Ultimate -type f \
     \( -name "*.lock" -o -name "port" -o -name ".s.*" \) -delete
   ```

3. **캐시 정리(설정/플러그인은 유지)**

   ```bash
   find ~/.var/app/com.jetbrains.IntelliJ-IDEA-Ultimate/.cache/JetBrains -maxdepth 2 \
     -type d \( -name "caches" -o -name "index" -o -name "compile-server" \) -exec rm -rf {} +
   ```

4. **안전 모드 실행**

   ```bash
   flatpak run com.jetbrains.IntelliJ-IDEA-Ultimate -disableNonBundledPlugins
   ```

5. **디스크와 권한 확인**

   ```bash
   df -h ~ /tmp
   sudo chown -R "$USER":"$USER" ~/.var/app/com.jetbrains.IntelliJ-IDEA-Ultimate
   ```

6. **여전히 안 될 경우 로그 확인**

   ```bash
   tail -n 200 ~/.var/app/com.jetbrains.IntelliJ-IDEA-Ultimate/.cache/JetBrains/IntelliJIdea*/log/idea.log
   ```
