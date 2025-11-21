# 📆 AI 연애 카톡 시뮬레이터 – 7일 완성 개발 로드맵 (MVP)

---

## 📅 **Day 0 – 사전 준비 (2~3시간)**
개발 착수 전에 환경 세팅 끝내기

### 🔧 준비 작업
- Flutter 설치 + 프로젝트 생성  
- Firebase 프로젝트 생성  
- Firestore / Auth / Functions 활성화  
- Python 환경 + openai/python 설치  
- GitHub 레포 세팅  

### 👍 출력 결과
- 개발 환경 정상  
- Firebase 연동까지 완료  

---

## 📅 **Day 1 – DB 구조 + Auth + 기본 라우팅 세팅**
전체 프로젝트 뼈대 구축

### 🔥 Firestore 컬렉션 만들기
- `users`  
- `scenarios`  
- `characters`  
- `sessions`  
- `messages`

### 🔥 Firebase Auth 연결
- 이메일 로그인  
- 구글 로그인  

### 🔥 Flutter 라우팅 구성
- `/splash`  
- `/login`  
- `/home`  
- `/scenario_list`  
- `/character_select`  
- `/simulator`  
- `/result`  
- `/real_chat`

### 🎯 Day 1 최종 목표
- 로그인 → 홈 이동 가능  
- 홈 UI 기본 구성 완료

---

## 📅 **Day 2 – 화면 와이어프레임 Flutter로 구현 (Dummy Data)**
UI부터 만들고, 데이터‧AI는 나중에 연결

### 구현할 화면 (레이아웃만)
- 홈 화면  
- 시나리오 리스트  
- 캐릭터 선택  
- 시뮬레이터(채팅 UI)  
- 엔딩 리포트  
- 실전 코치 붙여넣기 화면  

✔️ Dummy JSON 넣어서 화면만 완성  
✔️ 버튼 누르면 다음 화면으로 이동하도록 구성  

### 🎯 Day 2 최종 목표
- 앱 전체 플로우 UI를 눈으로 확인 가능

---

## 📅 **Day 3 – Python Cloud Functions (핵심 AI 기능)**
오늘은 AI “두뇌” 완성시키는 날

### 만들어야 하는 Cloud Functions
- `/simulate_message` – 유저 입력 → AI 답장 + 호감도 계산  
- `/coach_feedback` – 메시지 분석 → 코멘트 + 추천 멘트  
- `/analyze_real_chat` – 카톡 복붙 → 분위기/주도권/위험요소 분석  

### 🔥 Point
- 처음부터 완벽할 필요 없음  
- 프롬프트 기반 베이직 기능만 구현해도 MVP 충분

### 🎯 Day 3 최종 목표
- Postman 또는 Flutter에서 API 호출 → AI 정상 응답

---

## 📅 **Day 4 – Flutter ↔ Python 연동 + Firestore 저장**
UI에 실제 기능 붙이기 시작

### 해야 할 작업
- 입력창 → Python API 호출  
- AI 답장 → `messages` 컬렉션 저장  
- 세션(방) 구조 적용  
- 시나리오 ID 저장  
- 호감도 계산 UI 반영  
- 코치 패널 연동  

### 🔥 MVP 품질 Point
- 메시지 전송 → 로딩 → AI 답변 → 말풍선 표시

### 🎯 Day 4 최종 목표
- 시뮬레이터가 실제로 대화 가능  
- AI 답장이 잘 표시되는 수준까지 완성

---

## 📅 **Day 5 – 엔딩 로직 + 시나리오 5개 제작 + 코치 패널 완성**
마무리 단계

### 구현 내용
- 10~15턴 후 엔딩 계산  
- BAD/GOOD 엔딩 연출  
- 엔딩 리포트 UI 채움  
- 코치 패널 피드백 연결  
- 시나리오 5개 등록  

### 🎯 Day 5 최종 목표
- A/B/C/BAD 엔딩 모두 정상 동작  
- 캐릭터 성격 반응 일부 반영

---

## 📅 **Day 6 – 실전 카톡 코치 + 안정화 + 버그 수정**
MVP에서 꼭 필요한 최종 기능

### 기능 구현
- 텍스트 붙여넣기  
- Python 함수 호출  
- 분석 결과 표시  
- 추천 멘트 표시  
- 위험 포인트 표시  

### 안정화 작업
- UI 정리  
- 라우팅 정리  
- 에러 핸들링  
- 로딩 스피너 정리  

### 🎯 Day 6 최종 목표
- 실전 카톡 코치 기능 정상 동작  
- MVP 핵심 기능 전체 100% 구현

---

## 📅 **Day 7 – 최종 QA / 배포 / 테스트**
완성도 높이기

### 작업 목록
- 전체 플로우 테스트  
- 채팅 시뮬레이터 20회 이상 테스트  
- Firestore rule 강화  
- 크래시 로그 세팅  
- 성능 점검  

### 배포
- 웹 빌드 (`flutter build web`)  
- Firebase Hosting 배포  
- 모바일 앱은 APK 빌드까지  

### 🎯 Day 7 최종 목표
- “실제로 친구에게 보여줄 수 있는 버전” 완성  
- 베타 서비스 가능 상태
