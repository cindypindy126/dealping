# Dealping Project Status Report
> Morgan (PM) — 2026-03-21

## Project Status: READY FOR FIREBASE INTEGRATION

---

## Executive Summary

Phase 1~4 구현 완료. 모든 QA 사이클 통과. Firebase 연동 전 수동 설정 항목 존재하나 코드베이스는 프로덕션 준비 상태.

---

## 완료된 작업

### 기획/설계
- **Sam + Casey**: TASK-001~012 전체 스펙 + HYP-001~003 가설 카드 → `docs/task-specs.md`
- **Riley + Nova**: 6개 화면 Design Spec + 2개 Experience Spec → `docs/design-specs.md`

### Phase 1 — Flutter 프로젝트 초기화 ✅
- 패키지명: `com.dealping.app`, minSdk 24, targetSdk 35
- Material 3 테마: Primary #6C63FF, Secondary #FF6B9D, Pretendard 폰트
- Riverpod ProviderScope, GoRouter, AdMob meta-data
- **QA 수정**: AdMob APPLICATION_ID 추가, NavigationBarThemeData(M3) 전환, .env gitignore

### Phase 2 — 데이터 모델 & Firestore 레포지토리 ✅
- Freezed 모델 7개 (BenefitProvider, Benefit, Tier, Category, Merchant, UserProvider, MatchedBenefit)
- 레포지토리 4개 + BenefitMatchingService + AuthService
- **QA 수정**: `build.yaml` snake_case fieldRename (Firestore 키 매칭), 전 레포지토리 try/catch + RepositoryException, N+1 → Future.wait 병렬화, uid 가드

### Phase 3 — 핵심 화면 구현 ✅
- 온보딩(3슬라이드), 홈, 검색, 카테고리상세, 카드상세, 내카드, 설정 화면
- MockDataService: 5개 카드사, 5개 카테고리, 8개 가맹점, 14개 혜택
- SharedPreferences 기반 카드 등록 상태 관리
- **QA 수정**: load() 앱 시작 시 호출, /home 온보딩 가드

### Phase 4 — 관리자 웹 패널 ✅
- 별도 Flutter Web 프로젝트 (`C:\2_ClaudeTasks\DealPing\admin\`)
- 로그인, 대시보드, 카드/통신사 CRUD, 혜택 관리, 카테고리, 가맹점 관리
- 반응형 레이아웃 (NavigationRail ≥800px)
- **QA 수정**: hardcoded credentials kDebugMode 게이트, Benefits/Categories 편집 플로우, 유효성 검증 피드백

---

## 파일 구조

```
C:\2_ClaudeTasks\DealPing\
├── dealping-plan.md          # 기획서
├── docs/
│   ├── task-specs.md         # Sam + Casey 태스크 스펙
│   ├── design-specs.md       # Riley + Nova 디자인 스펙
│   └── project-status.md     # 본 문서
├── app/                      # Flutter 앱 (Android)
│   ├── lib/ (35 Dart files)
│   │   ├── core/            # theme, constants, router, utils
│   │   ├── data/            # models(7), repositories(4), services(3)
│   │   ├── features/        # auth, home, category, search, my_cards, provider_detail, settings
│   │   └── shared/          # widgets(3), providers
│   └── android/
└── admin/                    # Flutter Web 어드민
    └── lib/ (12 Dart files)
```

---

## 수동 설정 필요 항목 (Firebase 연동 전)

### 필수 (앱 실행 불가)
1. **Firebase 프로젝트 생성**
   - Firebase Console에서 프로젝트 생성
   - Android 앱 등록 (패키지: `com.dealping.app`)
   - `google-services.json` → `app/android/app/` 배치 (절대 커밋 금지)
   - `main.dart`에서 Firebase.initializeApp() 주석 해제

2. **Pretendard 폰트 파일**
   - `app/assets/fonts/`에 4개 파일 배치:
     - Pretendard-Regular.ttf, Pretendard-Medium.ttf, Pretendard-SemiBold.ttf, Pretendard-Bold.ttf
   - 다운로드: https://github.com/orioncactus/pretendard

### 릴리스 전 필수
3. **AdMob 실제 ID 교체**
   - `AndroidManifest.xml`의 테스트 App ID → 실제 AdMob App ID
   - `app_constants.dart`에 실제 Ad Unit ID 추가

4. **Firebase Auth 설정**
   - 익명 로그인 활성화 (앱)
   - 이메일/비밀번호 로그인 활성화 (어드민)
   - 어드민 계정 생성 후 `login_screen.dart` hardcoded credentials 제거

5. **Firestore 보안 규칙** (`firestore.rules` 작성 필요)
   ```
   users/{uid}/my_providers: auth.uid == uid
   benefit_providers, categories, merchants: read=all, write=admin only
   ```

6. **Windows Developer Mode 활성화** (flutter run 심볼릭 링크)
   - `ms-settings:developers`에서 개발자 모드 ON

7. **릴리스 서명 설정** (Play Store 배포 시)
   - keystore 생성 + `key.properties` 설정 (gitignore됨)

---

## QA 최종 결과

| Phase | Jordan | Sage | 수정 완료 |
|-------|--------|------|----------|
| Phase 1 | PASS WITH NOTES | FRAGILE → 수정 후 PASS | ✅ |
| Phase 2 | PASS (P0 FAIL 수정) | FRAGILE → 수정 후 개선 | ✅ |
| Phase 3 | PASS WITH NOTES | FRAGILE → 수정 후 개선 | ✅ |
| Phase 4 | PASS WITH NOTES | FRAGILE | 진행 중 |

---

## Casey 가설 카드 — 출시 후 검증 계획

| 가설 | 검증 지표 | 임계값 |
|------|----------|--------|
| HYP-001: 첫 세션 카드 등록율 | session 1 내 addProvider 호출 비율 | <25% → 게스트 모드 전환 |
| HYP-002: 혜택율 기반 정렬 신뢰도 | 1위 결과 탭 비율 | <45% → 가중 점수 모델 |
| HYP-003: 검색 vs 카테고리 진입 비율 | sessionEntryPoint 이벤트 | 카테고리 ≥40% → IA 재구성 |

---

## Morgan 최종 승인

**승인 조건:**
- [x] Phase 1~4 코드 구현 완료
- [x] `flutter analyze` 두 프로젝트 모두 No issues
- [x] QA P0/P1 항목 전원 수정
- [x] Firebase 연동 준비 체크리스트 문서화
- [ ] Firebase 실제 연동 (다음 단계)
- [ ] 초기 데이터 입력 (50~100 카드/가맹점)
- [ ] AdMob 실제 배너 테스트

**Morgan 판정: Phase 1~4 MVP 코드베이스 승인. Firebase 연동 및 데이터 입력 단계로 이행.**
