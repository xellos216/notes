# 📱 Mobile Viewport Override Bookmarklet (Safari 전용)

iPhone Safari에서 데스크탑 전용 페이지에 접근하기 위한 **뷰포트 강제 설정 북마클릿**입니다.  
`meta viewport`를 `1280x800`으로 설정하여 데스크탑 화면을 불러오게 합니다.

---

## ✅ 사용 목적

- 모바일 접속을 제한하거나 데스크탑에 최적화된 웹페이지(nbcamp.kr 등)에 모바일에서 접근할 때 사용
- `User-Agent` 변경 없이 뷰포트만으로 데스크탑 화면을 로딩할 수 있는 경우에 적합

---

## 🛠 사용 방법

1. Safari에서 아무 웹페이지를 열고 북마크 추가
2. 해당 북마크를 편집하여 URL에 아래 코드 입력:

```javascript
javascript:(function(){
  var m = document.querySelector('meta[name="viewport"]');
  if (m) {
    m.setAttribute("content", "width=1280, height=800");
  } else {
    var meta = document.createElement('meta');
    meta.name = "viewport";
    meta.content = "width=1280, height=800";
    document.head.appendChild(meta);
  }
  alert("✅ 데스크탑 뷰포트 적용됨 (1280×800)");
})();
```

3. `https://nbcamp.kr` 등 접속 후 해당 북마크 실행
4. 알림창 확인 후, 데스크탑 레이아웃이 정상 표시되는지 확인

---

## 📁 파일로 저장할 경우

이 코드를 `.js` 파일로 따로 저장하고 싶다면 아래와 같이 사용 가능합니다:

파일명: `viewport_override.js`

```javascript
// Safari 북마클릿용: 모바일 뷰포트를 데스크탑으로 강제 변경
(function(){
  var m = document.querySelector('meta[name="viewport"]');
  if (m) {
    m.setAttribute("content", "width=1280, height=800");
  } else {
    var meta = document.createElement('meta');
    meta.name = "viewport";
    meta.content = "width=1280, height=800";
    document.head.appendChild(meta);
  }
})();
```

---

## 🔒 참고 사항

- 완전 자동 실행은 Safari 보안 정책상 불가능합니다. 북마클릿은 수동 실행 필요.
- Mac 없이 iOS 내에서 가능한 가장 높은 수준의 자동화 방식입니다.
