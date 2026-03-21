# Dealping 앱 기획서

> **최종 업데이트:** 2026-03-21
> **앱 이름:** Dealping (딜핑)
> **플랫폼:** Android (Flutter, 향후 iOS 확장 가능)
> **백엔드:** Firebase (Firestore + Cloud Functions + Auth + Hosting)
> **수익 모델:** 무료 + 배너 광고 (향후 프리미엄 기능 확장 가능)

---

## 1. 앱 개요

### 1.1 핵심 컨셉
사용자가 보유한 신용/체크카드 및 통신사 혜택 정보를 기반으로, 특정 소비 목적(가맹점/업종)에 가장 유리한 카드 또는 통신사 혜택을 즉시 추천해주는 앱.

### 1.2 핵심 차별점
- **"내가 가진 것 기반"**: 새 카드 추천이 아닌, 보유 카드/통신사 중 최적 혜택 매칭
- **점진적 필터링**: 카테고리만 선택해도 업종 전체 할인 카드 표시 → 가맹점 특정하면 추가 매칭
- **원스텝 검색 + 카테고리 탐색 병행**: 홈에서 바로 검색 가능 + 카테고리 브라우징도 가능
- **카드와 통신사 혜택 통합**: 통신사도 카드와 동일하게 "혜택 제공자"로 취급

### 1.3 타겟 사용자
- 주 타겟: 카드 5장 이상 보유한 혜택 매니아 (혜택을 다 외우지 못하는 사용자)
- 서브 타겟: 카드 2~3장 보유한 일반 사용자

### 1.4 상표 관련 참고
- "Dealping"은 조어(Deal + ping)로 식별력 충분
- Google Play에서 동일 이름 앱 미확인 (2026-03-21 기준)
- 출시 전 KIPRIS에서 "딜핑" / "Dealping" 상표 검색 권장 (제9류, 제36류)

---

## 2. 디자인 가이드라인

### 2.1 디자인 컨셉
- **키워드**: 깔끔, 미니멀, 밝고 세련된, 부드러운
- **참고 방향**: 토스/뱅크샐러드의 깔끔함 + 살짝 더 컬러풀하고 부드러운 느낌
- **다크모드**: 기본 라이트, 다크모드는 후속 업데이트

### 2.2 컬러 팔레트 (제안)
```
Primary:      #6C63FF (부드러운 퍼플 블루 - 신뢰감 + 세련됨)
Secondary:    #FF6B9D (소프트 코랄 핑크 - 할인/혜택 강조)
Background:   #FAFBFE (거의 흰색에 살짝 블루 톤)
Surface:      #FFFFFF
Text Primary: #1A1A2E (거의 검정이지만 부드러운)
Text Secondary: #6B7280
Success:      #10B981 (혜택 있음 표시)
Border:       #E5E7EB
```

### 2.3 타이포그래피
- 한글: Pretendard (무료, 깔끔한 고딕)
- 영문/숫자: Inter 또는 Pretendard 통일
- 카드명/혜택율은 약간 볼드하게, 본문은 Regular

### 2.4 아이콘/일러스트
- 카테고리 아이콘: 라인 아이콘 스타일 (Lucide, Phosphor 등)
- 카드 표시: 카드사 로고 + 카드명 (실제 카드 이미지는 저작권 이슈로 제외)
- 통신사: SKT/KT/LG U+ 로고 또는 아이콘

---

## 3. 화면 플로우 (Screen Flow)

### 3.1 온보딩
```
[스플래시] → [간단 소개 (2~3슬라이드)] → [내 카드 등록 (건너뛰기 가능)] → [홈]
```

### 3.2 메인 화면 구조 (Bottom Navigation)
```
[홈] [내 카드] [설정]
```

### 3.3 홈 화면
```
┌─────────────────────────────┐
│  Dealping 로고               │
├─────────────────────────────┤
│  🔍 어디서 결제하세요?       │  ← 통합 검색창 (가맹점명 직접 검색)
├─────────────────────────────┤
│  ☕ 카페  ⛽ 주유  🏪 편의점  │  ← 카테고리 그리드
│  🛒 마트  🍕 배달  🛍️ 쇼핑   │
│  🚌 교통  🎬 문화  💊 의료   │
│  📱 온라인 🏨 여행  ··· 더보기│
└─────────────────────────────┘
```

### 3.4 카테고리 진입 시 (예: 카페)
```
┌─────────────────────────────┐
│  ← 카페                     │
├─────────────────────────────┤
│  🔍 가맹점 검색 (스타벅스...)│  ← 카테고리 내 검색창
├─────────────────────────────┤
│  📋 내 혜택 카드 (업종 전체) │  ← 업종 레벨 매칭 결과 즉시 표시
│  ┌───────────────────────┐  │
│  │ A카드 (신용)           │  │
│  │ 모든 커피업종 10% 할인  │  │
│  ├───────────────────────┤  │
│  │ LG U+ 멤버십           │  │
│  │ 커피전문점 5% 할인      │  │
│  └───────────────────────┘  │
│                             │
│  * 전월실적 및 합산 할인액은 │
│    카드 개별 정보를 참고하세요│
└─────────────────────────────┘
```

### 3.5 가맹점 검색 결과 (예: 카페 > 스타벅스)
```
┌─────────────────────────────┐
│  ← 카페 > 스타벅스           │
├─────────────────────────────┤
│  📋 내 혜택 카드             │
│  ┌───────────────────────┐  │
│  │ 🏆 B카드 (체크)  ▶    │  │  ← ▶ 탭하면 카드 상세로 이동
│  │ 스타벅스 20% 할인      │  │
│  ├───────────────────────┤  │
│  │ A카드 (신용)     ▶    │  │
│  │ 모든 커피업종 10% 할인  │  │
│  ├───────────────────────┤  │
│  │ LG U+ 멤버십     ▶   │  │
│  │ 커피전문점 5% 할인      │  │
│  └───────────────────────┘  │
│                             │
│  * 전월실적 및 합산 할인액은 │
│    카드 개별 정보를 참고하세요│
└─────────────────────────────┘
```

### 3.6 카드 상세 페이지 (카드명 탭 시)
```
┌─────────────────────────────┐
│  ← B카드 (체크)              │
├─────────────────────────────┤
│  [우리카드 로고]              │
│  우리카드 B카드               │
│  체크카드                     │
├─────────────────────────────┤
│  📊 전월실적 구간별 혜택      │
│  ┌───────────────────────┐  │
│  │ 30만 이상  │ 합산 1만원  │  │
│  │ 60만 이상  │ 합산 1.5만원│  │
│  │ 100만 이상 │ 합산 3만원  │  │
│  └───────────────────────┘  │
├─────────────────────────────┤
│  🎁 전체 혜택 목록            │
│  • 스타벅스 20% 할인          │
│  • 모든 편의점 5% 할인        │
│  • 대중교통 10% 할인          │
│  • 온라인쇼핑 적립 1%         │
│  ···                         │
├─────────────────────────────┤
│  혜택 유형: 할인 / 캐시백     │
│  월 할인 한도: 30,000원       │
│  연회비: 없음                 │
└─────────────────────────────┘
```

### 3.7 내 카드 관리 탭
```
┌─────────────────────────────┐
│  내 카드 & 통신사             │
├─────────────────────────────┤
│  [+ 카드/통신사 추가]         │  ← 검색으로 추가
├─────────────────────────────┤
│  💳 신용카드 (3)              │
│  • 우리카드 A카드             │
│  • 신한 B카드                │
│  • 현대 C카드                │
├─────────────────────────────┤
│  💳 체크카드 (1)              │
│  • 우리카드 D카드             │
├─────────────────────────────┤
│  📱 통신사 (1)               │
│  • LG U+ 멤버십              │
└─────────────────────────────┘
```

### 3.8 카드/통신사 등록 플로우
```
[+ 추가] → 검색창 ("언택트" 입력)
→ 검색 결과:
  우리카드 - 언택트 (신용)
  우리카드 - 언택트 (체크)
→ 사용자 선택 → 등록 완료
```

---

## 4. 데이터베이스 스키마 (Firestore)

### 4.1 컬렉션 구조

#### `benefit_providers` (카드/통신사 — 혜택 제공자)
```json
{
  "id": "woori_untact_credit",
  "name": "우리카드 언택트",
  "provider_type": "card",           // "card" | "telecom"
  "card_type": "credit",             // "credit" | "debit" | null(통신사)
  "issuer": "woori",                 // 카드사/통신사 코드
  "issuer_name": "우리카드",
  "annual_fee": 0,
  "image_url": "",                   // 카드 이미지 (선택)
  "is_active": true,                 // 현재 발급 가능 여부
  "created_at": "2026-03-21T00:00:00Z",
  "updated_at": "2026-03-21T00:00:00Z"
}
```

#### `benefit_providers/{id}/benefits` (서브컬렉션 — 혜택 상세)
```json
{
  "id": "benefit_001",
  "category_id": "cafe",             // 카테고리 코드
  "merchant_id": "starbucks",        // 특정 가맹점 (null이면 업종 전체)
  "benefit_type": "discount",        // "discount" | "cashback" | "point"
  "benefit_rate": 20,                // 할인율 (%)
  "benefit_fixed": null,             // 정액 할인 (원) — rate와 택1
  "benefit_description": "스타벅스 20% 할인",
  "conditions": "1일 1회",
  "is_active": true
}
```

#### `benefit_providers/{id}/tiers` (서브컬렉션 — 전월실적 구간)
```json
{
  "min_spend": 300000,               // 전월실적 최소 (원)
  "max_spend": 600000,               // 전월실적 최대 (null이면 무제한)
  "monthly_discount_limit": 10000,   // 합산 할인 한도 (원)
  "description": "30만원 이상 ~ 60만원 미만: 월 1만원 한도"
}
```

#### `categories` (카테고리)
```json
{
  "id": "cafe",
  "name": "카페",
  "icon": "coffee",                  // 아이콘 코드
  "sort_order": 1,
  "is_active": true
}
```

#### `merchants` (가맹점)
```json
{
  "id": "starbucks",
  "name": "스타벅스",
  "category_id": "cafe",
  "aliases": ["스벅", "starbucks"],  // 검색용 별칭
  "is_franchise": true,
  "sort_order": 1,                   // 카테고리 내 정렬
  "is_active": true
}
```

#### `users/{uid}/my_providers` (서브컬렉션 — 사용자 등록 카드/통신사)
```json
{
  "provider_id": "woori_untact_credit",
  "added_at": "2026-03-21T00:00:00Z",
  "nickname": "",                    // 사용자 커스텀 별명 (선택)
  "custom_benefits": []              // 사용자가 직접 추가/수정한 혜택 (향후)
}
```

### 4.2 혜택 매칭 로직 (핵심 알고리즘)
```
입력: 사용자 UID, 카테고리 ID, 가맹점 ID (선택)

1. 사용자의 등록된 provider ID 목록 조회
2. 해당 provider들의 benefits 서브컬렉션에서:
   a. category_id == 선택한 카테고리 AND merchant_id == null  → 업종 전체 혜택
   b. category_id == 선택한 카테고리 AND merchant_id == 선택한 가맹점  → 가맹점 특정 혜택
3. (a) + (b) 결과를 합쳐서 benefit_rate 내림차순 정렬
4. 결과 반환 (혜택 정보 + provider 기본 정보)
```

### 4.3 인덱스 전략
- `benefits`: category_id + is_active 복합 인덱스
- `merchants`: category_id + is_active + name 복합 인덱스
- `merchants`: name 텍스트 검색 (aliases 배열 포함)

---

## 5. 기술 스택 상세

### 5.1 프론트엔드 (Flutter)
- **상태관리**: Riverpod 2.x (가장 현대적이고 안정적)
- **라우팅**: GoRouter
- **UI**: Material 3 + 커스텀 위젯
- **로컬 저장**: SharedPreferences (간단 설정), Hive (오프라인 캐시)
- **광고**: Google AdMob (배너)
- **폰트**: google_fonts 패키지 (Pretendard)
- **아이콘**: lucide_icons 또는 phosphor_flutter

### 5.2 백엔드 (Firebase)
- **Firestore**: 메인 DB
- **Cloud Functions (Node.js)**: 크롤러, 데이터 정제, 푸시 알림
- **Firebase Auth**: 익명 로그인 (최소한의 진입 장벽) + 이메일/구글 선택
- **Firebase Hosting**: 관리자 웹 페이지
- **Cloud Storage**: 카드사/통신사 로고 이미지

### 5.3 관리자 웹 (Admin Panel)
- **프레임워크**: Flutter Web 또는 React (Firebase Hosting)
- **기능**:
  - 카드/통신사 CRUD (추가/수정/삭제/활성화)
  - 혜택 정보 CRUD
  - 가맹점/카테고리 관리
  - 사용자 통계 대시보드 (간단)
  - 크롤러 실행/결과 확인

### 5.4 크롤러
- **기술**: Python (Cloud Functions 또는 별도 서버)
- **대상**: 카드사 공식 홈페이지, 카드고릴라 등 정리 사이트
- **주기**: 주 1회 신규 카드 체크, 월 1회 혜택 변경 체크
- **규칙**: robots.txt 준수, User-Agent 명시, 크롤링 허용된 페이지만 수집
- **플로우**: 크롤링 → 관리자 검증 큐 → 승인 시 DB 반영

---

## 6. MVP 범위 (v1.0)

### 6.1 포함 기능
- [x] 사용자 회원가입/로그인 (익명 + 구글/이메일)
- [x] 카드/통신사 검색 및 등록 (내 카드 관리)
- [x] 홈 화면 (통합 검색 + 카테고리 그리드)
- [x] 카테고리별 업종 전체 혜택 매칭
- [x] 가맹점 검색 시 추가 매칭
- [x] 카드/통신사 상세 페이지 (전월실적 구간, 전체 혜택 목록)
- [x] 배너 광고 (AdMob)
- [x] 관리자 웹 페이지 (카드/가맹점/혜택 CRUD)

### 6.2 MVP 제외 (v2.0 이후)
- [ ] 사용자 혜택 수정/제안 기능
- [ ] 푸시 알림 (새 혜택, 혜택 변경)
- [ ] 다크모드
- [ ] 즐겨찾기 가맹점
- [ ] 자동 크롤러 (초기에는 수동/반자동)
- [ ] iOS 출시
- [ ] 위치 기반 주변 가맹점 추천
- [ ] 프리미엄 기능 (광고 제거, 혜택 비교 등)

---

## 7. 초기 데이터 구축 계획

### 7.1 카테고리 (초기 12~15개)
카페, 주유, 편의점, 마트/대형할인점, 배달앱, 온라인쇼핑, 교통(대중교통), 외식/레스토랑, 문화/영화, 의료/약국, 통신요금, 여행/항공, 교육/학원, 구독서비스

### 7.2 가맹점 (초기 300~500개)
주요 프랜차이즈 위주로 수동 등록:
- 카페: 스타벅스, 이디야, 투썸, 메가커피, 컴포즈, 빽다방 등
- 편의점: GS25, CU, 세븐일레븐, 이마트24
- 마트: 이마트, 홈플러스, 코스트코, 트레이더스
- 배달: 배달의민족, 요기요, 쿠팡이츠
- 등등...

### 7.3 카드/통신사 (초기 50~100개)
인기 카드 위주:
- 삼성카드, 신한카드, 현대카드, 우리카드, KB국민카드, 하나카드, NH농협, 롯데카드
- SKT, KT, LG U+ 멤버십

---

## 8. 프로젝트 구조 (Flutter)

```
dealping/
├── lib/
│   ├── main.dart
│   ├── app.dart                     # MaterialApp, 테마, 라우팅
│   ├── core/
│   │   ├── theme/                   # 컬러, 타이포, 테마 데이터
│   │   ├── constants/               # 앱 상수
│   │   ├── utils/                   # 유틸리티 함수
│   │   └── router/                  # GoRouter 설정
│   ├── data/
│   │   ├── models/                  # 데이터 모델 (Freezed)
│   │   ├── repositories/            # Firestore 레포지토리
│   │   └── services/                # Firebase 서비스
│   ├── features/
│   │   ├── auth/                    # 로그인/회원가입
│   │   ├── home/                    # 홈 화면 (검색 + 카테고리)
│   │   ├── category/                # 카테고리 상세 (혜택 매칭)
│   │   ├── search/                  # 통합 검색
│   │   ├── my_cards/                # 내 카드 관리
│   │   ├── provider_detail/         # 카드/통신사 상세
│   │   └── settings/                # 설정
│   └── shared/
│       ├── widgets/                 # 공용 위젯
│       └── providers/               # 공용 Riverpod 프로바이더
├── assets/
│   ├── icons/                       # 카테고리 아이콘
│   ├── images/                      # 앱 로고 등
│   └── fonts/                       # Pretendard 폰트
├── firebase/
│   └── functions/                   # Cloud Functions
├── admin/                           # 관리자 웹 (별도 프로젝트)
├── pubspec.yaml
└── README.md
```

---

## 9. Claude Code 작업 프롬프트

아래 프롬프트를 Claude Code에서 사용하여 프로젝트를 시작할 수 있습니다.

---

### Phase 1: 프로젝트 초기 설정

```
Dealping이라는 Flutter 앱 프로젝트를 초기화해줘.

# 프로젝트 기본 정보
- 앱 이름: Dealping (딜핑)
- 패키지명: com.dealping.app
- 최소 SDK: Android API 24 (Android 7.0)
- Flutter 최신 안정 버전 사용

# 핵심 패키지 설치
- firebase_core, cloud_firestore, firebase_auth
- flutter_riverpod (상태관리)
- go_router (라우팅)
- google_fonts (Pretendard 폰트)
- google_mobile_ads (AdMob 배너)
- freezed, freezed_annotation, json_annotation (모델)
- build_runner, json_serializable (코드 생성)
- shared_preferences
- lucide_icons

# 프로젝트 구조
features 기반 폴더 구조로 만들어줘:
- core/ (theme, constants, utils, router)
- data/ (models, repositories, services)
- features/ (auth, home, category, search, my_cards, provider_detail, settings)
- shared/ (widgets, providers)

# 테마 설정
Material 3 기반, 밝고 깔끔한 디자인:
- Primary: #6C63FF
- Secondary: #FF6B9D
- Background: #FAFBFE
- Surface: #FFFFFF
- Text Primary: #1A1A2E
- Text Secondary: #6B7280
- Pretendard 폰트 적용
```

### Phase 2: 데이터 모델 & Firestore 설정

```
Dealping 앱의 Firestore 데이터 모델을 Freezed로 만들어줘.

# 컬렉션 및 모델:

1. BenefitProvider (benefit_providers 컬렉션)
   - id, name, provider_type(card/telecom), card_type(credit/debit/null)
   - issuer, issuer_name, annual_fee, image_url, is_active
   - created_at, updated_at

2. Benefit (benefit_providers/{id}/benefits 서브컬렉션)
   - id, category_id, merchant_id(nullable), benefit_type(discount/cashback/point)
   - benefit_rate(%), benefit_fixed(원), benefit_description, conditions, is_active

3. Tier (benefit_providers/{id}/tiers 서브컬렉션)
   - min_spend, max_spend(nullable), monthly_discount_limit, description

4. Category (categories 컬렉션)
   - id, name, icon, sort_order, is_active

5. Merchant (merchants 컬렉션)
   - id, name, category_id, aliases(List<String>), is_franchise, sort_order, is_active

6. UserProvider (users/{uid}/my_providers 서브컬렉션)
   - provider_id, added_at, nickname

# Repository 패턴:
각 컬렉션에 대해 Repository 클래스를 만들고 Riverpod provider로 제공.
특히 혜택 매칭 로직을 BenefitMatchingService로 분리:
- 입력: userId, categoryId, merchantId(optional)
- 로직: 사용자 등록 provider → 해당 provider의 benefits에서 category 매칭 + merchant 매칭 → 합산 후 benefit_rate 내림차순 정렬
```

### Phase 3: 핵심 화면 구현

```
Dealping 앱의 핵심 화면들을 구현해줘.

# 1. 홈 화면 (HomeScreen)
- 상단: 앱 로고 + "Dealping"
- 검색창: "어디서 결제하세요?" 플레이스홀더, 탭하면 SearchScreen으로 이동
- 카테고리 그리드: 3열, 아이콘 + 이름, Firestore에서 categories 로드
- 디자인: 둥근 카드 형태, 부드러운 그림자, 깔끔한 여백

# 2. 검색 화면 (SearchScreen)
- 상단 검색창 (자동포커스)
- 입력 시 merchants 컬렉션에서 name/aliases 실시간 필터링
- 결과 탭하면 → 해당 merchant의 category로 CategoryDetailScreen 이동 (merchant 선택된 상태)

# 3. 카테고리 상세 화면 (CategoryDetailScreen)
- 상단: 카테고리명 + 카테고리 내 가맹점 검색창
- 본문: 즉시 업종 전체 혜택 매칭 결과 리스트 표시
- 가맹점 검색/선택 시: 업종 전체 + 가맹점 특정 혜택 합쳐서 표시
- 각 카드 항목: 카드명(탭 가능) + 혜택 요약 한 줄
- 하단 안내: "전월실적 및 합산 할인액은 카드 개별 정보를 참고하세요"
- 혜택 없으면: "등록된 카드 중 해당 혜택이 없습니다" 안내

# 4. 카드/통신사 상세 화면 (ProviderDetailScreen)
- 상단: 카드사 로고 + 카드명 + 신용/체크 뱃지
- 전월실적 구간 테이블 (tiers)
- 전체 혜택 목록 (benefits) - 카테고리별 그룹핑
- 혜택 유형 뱃지 (할인/캐시백/포인트)
- 월 할인 한도, 연회비 정보

# 5. 내 카드 관리 (MyCardsScreen)
- 신용카드/체크카드/통신사 섹션으로 구분
- [+ 추가] 버튼 → 검색 다이얼로그 (benefit_providers에서 검색)
- 스와이프로 삭제 (확인 다이얼로그)
- 등록된 카드가 없으면 빈 상태 + 등록 유도 UI

# 디자인 원칙:
- 카드형 UI (둥근 모서리, 부드러운 그림자)
- 충분한 여백 (padding 16~20)
- 혜택율은 크고 볼드하게 (Primary 컬러)
- 전환 애니메이션 부드럽게
```

### Phase 4: 관리자 웹 패널

```
Dealping 관리자 웹 페이지를 만들어줘. Firebase Hosting에 배포할 용도.

# 기술: Flutter Web (앱과 모델 공유) 또는 React + Firebase SDK

# 필요 페이지:
1. 로그인 (관리자 이메일/비밀번호)
2. 대시보드 (총 카드 수, 가맹점 수, 사용자 수)
3. 카드/통신사 관리 (CRUD, 검색, 필터)
4. 혜택 관리 (카드별 혜택 추가/수정/삭제)
5. 카테고리 관리 (순서 변경, 추가/삭제)
6. 가맹점 관리 (CRUD, 별칭 관리)
7. 전월실적 구간 관리 (카드별)

# 기능:
- 카드 추가 시: 기본 정보 입력 → 혜택 하나씩 추가 → 전월실적 구간 추가
- 일괄 수정 기능 (is_active 토글 등)
- 데이터 유효성 검증
```

---

## 10. 일정 (예상)

| Phase | 내용 | 예상 기간 |
|-------|------|----------|
| 1 | 프로젝트 초기 설정 + 테마 | 1~2일 |
| 2 | 데이터 모델 + Firestore 연동 | 2~3일 |
| 3 | 핵심 화면 UI 구현 | 5~7일 |
| 4 | 혜택 매칭 로직 | 2~3일 |
| 5 | 관리자 웹 패널 | 3~5일 |
| 6 | 초기 데이터 입력 (50~100 카드) | 3~5일 |
| 7 | AdMob 연동 + 테스트 | 1~2일 |
| 8 | 버그 수정 + 폴리싱 | 3~5일 |
| **합계** | | **약 3~4주** |

---

## 부록: 카드사 코드표

| 코드 | 카드사 |
|------|--------|
| shinhan | 신한카드 |
| samsung | 삼성카드 |
| hyundai | 현대카드 |
| woori | 우리카드 |
| kb | KB국민카드 |
| hana | 하나카드 |
| nh | NH농협카드 |
| lotte | 롯데카드 |
| bc | BC카드 |
| skt | SK텔레콤 |
| kt | KT |
| lgu | LG U+ |
