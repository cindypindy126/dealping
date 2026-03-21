# Dealping Design Specs
**Version:** 1.0
**Status:** Ready for Dev
**Authors:** Riley (UI/UX) + Nova (Experience)
**Date:** 2026-03-21

---

# PART 1 — RILEY'S DESIGN SPECS

---

## Design Spec: DS-001 — Home Screen
Version: 1.0
Status: Ready for Dev

### Overview
The Home Screen is the primary entry point. Users arrive here after onboarding or returning from any other flow. It surfaces the two core actions: search for a merchant by name, and browse by category. When no cards are registered, it must gently push the user toward card registration without making them feel blocked.

### User Flow
1. User opens the app (or returns from another screen via back navigation).
2. App bar shows "Dealping" wordmark.
3. Search bar is visible but not focused — tapping it navigates to Search Screen.
4. Category grid loads from Firestore; if cards are registered, grid is fully active.
5. If no cards registered: empty state replaces the category grid area.

### Components

**AppBar**
- Widget: standard `AppBar` with no elevation, `backgroundColor: #FAFBFE`
- Left: "Dealping" wordmark — Pretendard Bold 22px, color `#6C63FF`
- Right: optional icon button for My Cards (`CreditCard` Lucide icon, 24px, `#1A1A2E`)
- No back arrow on this screen

**Search Bar (passive)**
- Widget: `GestureDetector` wrapping a `Container` that looks like a TextField but is not focusable here
- Height: 52px
- Background: `#FFFFFF`
- Border: 1.5px solid `#E5E7EB`, borderRadius 12px
- Shadow: `BoxShadow(color: #1A1A2E0A, blurRadius: 8, offset: Offset(0, 2))`
- Left icon: `Search` Lucide, 20px, `#6B7280`
- Placeholder text: "어디서 결제하세요?", Pretendard Regular 15px, `#6B7280`
- Tap behavior: navigate to Search Screen with push transition (no focus confusion)
- Margin: 16px horizontal, 12px top from AppBar bottom, 16px bottom to grid

**Category Grid**
- Widget: `GridView.builder` with `SliverGridDelegateWithFixedCrossAxisCount`
- `crossAxisCount: 3`
- `childAspectRatio: 1.0` (square cells)
- `crossAxisSpacing: 8`, `mainAxisSpacing: 8`
- Padding: 16px all sides
- Each cell: `InkWell` > `Column(mainAxisAlignment: center)` > icon container + label
  - Icon container: 48x48px circle, background `#EEF2FF` (light purple tint), icon Lucide line 24px, color `#6C63FF`
  - Label: Pretendard Medium 12px, `#1A1A2E`, maxLines 1, overflow ellipsis, 6px top margin
- Active tap: ripple with `splashColor: #6C63FF1A`, borderRadius 12px on cell container
- Cell container: `Card` with `elevation: 0`, `color: #FFFFFF`, `borderRadius: 12px`

**Category icons (Lucide mapping)**
| Category key | Lucide icon |
|---|---|
| cafe | `Coffee` |
| gas | `Fuel` |
| convenience | `ShoppingBag` |
| mart | `ShoppingCart` |
| delivery | `Package` |
| shopping | `Store` |
| transit | `Train` |
| culture | `Ticket` |
| medical | `Heart` |
| online | `Globe` |
| travel | `Plane` |
| (fallback) | `Tag` |

**Empty State (no cards registered)**
- Replaces category grid
- Centered in remaining screen space
- Illustration area: 120x120px placeholder (`Container` with `#EEF2FF` background, borderRadius 24px) — insert final SVG here
- Title: "아직 카드가 없어요", Pretendard SemiBold 17px, `#1A1A2E`, centered, 24px top margin
- Subtitle: "카드를 등록하면 최적 혜택을 바로 알 수 있어요", Pretendard Regular 14px, `#6B7280`, centered, 8px top margin, horizontal padding 32px
- CTA button: `ElevatedButton`, "카드 등록하기", height 48px, width fills to 80% of screen, background `#6C63FF`, text Pretendard SemiBold 15px white, borderRadius 24px, 24px top margin

### Visual Specs
- Background: `#FAFBFE` (Scaffold)
- Surface (cards): `#FFFFFF`
- Typography:
  - Wordmark: Pretendard Bold 22px, `#6C63FF`
  - Category label: Pretendard Medium 12px, `#1A1A2E`
  - Search placeholder: Pretendard Regular 15px, `#6B7280`
  - Empty state title: Pretendard SemiBold 17px, `#1A1A2E`
  - Empty state subtitle: Pretendard Regular 14px, `#6B7280`
- Spacing: 4px base grid; outer padding 16px
- Transitions: Search bar tap → `MaterialPageRoute` with default forward slide

### States to Cover
- [x] Loaded with categories (from Firestore)
- [x] Empty state (no cards registered)
- [x] Loading state: show shimmer skeleton grid (3x3 placeholder cells, `shimmer` package or manual AnimatedContainer), shown while Firestore categories fetch
- [x] Error state (Firestore unreachable): show subtle snackbar "카드 정보를 불러오지 못했어요. 잠시 후 다시 시도해주세요." with retry action; category grid shows cached data if available
- [x] Edge case: very long category label (12+ chars) — ellipsis, never wrap to 2 lines

### Accessibility Notes
- Search bar: `Semantics(label: '상점 검색', button: true)` — it is not a real input here
- Category cells: `Semantics(label: '${category.displayName} 카테고리')` on each `InkWell`
- Empty state CTA: `Semantics(label: '카드 등록하기 버튼')`
- Focus order: AppBar right icon → Search bar → Category grid cells (left-to-right, top-to-bottom)
- Color contrast: `#6B7280` on `#FAFBFE` = 4.6:1 (AA pass for large text); `#1A1A2E` on `#FFFFFF` = 16:1 (AAA)
- Minimum tap target: 48x48px (category cell Container should be at least this even if visual is smaller)

### Assets
- Wordmark: Text widget (no image asset needed initially)
- Lucide icons: `lucide_icons` Flutter package
- Empty state illustration: SVG placeholder, 120x120px, final asset TBD

---

## Design Spec: DS-002 — Search Screen
Version: 1.0
Status: Ready for Dev

### Overview
The Search Screen is activated from the Home Screen search bar. It provides real-time name/alias filtering of merchants from Firestore. The user has already expressed intent by tapping search — auto-focus and clean results with zero friction are the goal.

### User Flow
1. User taps Search bar on Home Screen.
2. Search Screen opens with keyboard auto-showing and input focused.
3. User types — results filter in real-time (debounce 300ms recommended).
4. User taps a result — navigates to Category Detail Screen for that merchant's category, with merchant pre-selected.
5. User taps back — returns to Home Screen.

### Components

**AppBar / Search Header**
- No standard AppBar widget; use a custom header row
- Back button: `IconButton` with `ArrowLeft` Lucide 24px, `#1A1A2E`, taps to `Navigator.pop()`
- Search `TextField`:
  - `autofocus: true`
  - `decoration: InputDecoration(hintText: '어디서 결제하세요?', border: InputBorder.none, hintStyle: TextStyle(color: #6B7280, fontSize: 16, fontFamily: 'Pretendard'))`
  - `style: TextStyle(color: #1A1A2E, fontSize: 16, fontFamily: 'Pretendard', fontWeight: FontWeight.w500)`
  - Height of this row: 56px, padding 16px left for back button, 8px between back button and field, 16px right
  - Bottom border only: 1px `#E5E7EB` (use `UnderlineInputBorder` on the Container, not the TextField itself)
  - Clear button: `IconButton` with `X` Lucide 20px, `#6B7280`, visible only when text is non-empty, `onPressed: controller.clear()`
- Row: `[BackButton] [TextField (expanded)] [ClearButton]`

**Results List**
- Widget: `ListView.builder`
- Each result: `ListTile`-equivalent via custom widget for control
  - Height: 64px minimum
  - Left: `SearchResult` icon area — category icon 40x40px circle, background `#EEF2FF`, Lucide icon 20px `#6C63FF`
  - Center: Column
    - Merchant name: Pretendard SemiBold 15px, `#1A1A2E`
    - Category label badge (below name): `Container` height 20px, padding 4px horizontal, background `#EEF2FF`, borderRadius 6px, text Pretendard Medium 11px `#6C63FF`
  - Divider: `Divider` height 1, color `#E5E7EB`, indent 72px (aligns under text, not icon)
- Tap: navigate to Category Detail Screen with `merchant` argument

**Empty State (no results)**
- Center of remaining screen area
- Icon: `SearchX` Lucide 48px `#6B7280`
- Text: "검색 결과가 없습니다", Pretendard Regular 15px `#6B7280`, 12px top margin
- Sub-text: "다른 이름으로 검색해 보세요", Pretendard Regular 13px `#6B7280`

**Pre-search state (field empty, no query)**
- Show placeholder content: "최근 검색" section (if history implemented later) or blank — do not show empty state icon
- Currently: show blank white space (simple, no clutter)

### Visual Specs
- Background: `#FFFFFF` (this screen should feel like an elevated modal over home)
- Header row background: `#FFFFFF`
- Typography:
  - Search input: Pretendard Medium 16px, `#1A1A2E`
  - Hint: Pretendard Regular 16px, `#6B7280`
  - Merchant name: Pretendard SemiBold 15px, `#1A1A2E`
  - Category badge: Pretendard Medium 11px, `#6C63FF`
- Transition in: slide up from bottom with 250ms ease-out curve (`Curves.easeOutCubic`), or default forward push — match platform convention; prefer slide-up for modal feel
- Keyboard: opens immediately, dismisses on back

### States to Cover
- [x] Pre-search (empty field): clean slate
- [x] Typing (results filtering): live list update
- [x] Results found: list of merchants
- [x] Empty results: no-results state
- [x] Loading (initial merchant list fetch): shimmer rows (height 64px, 16px horizontal padding)
- [x] Error (fetch failed): snackbar "가맹점 목록을 불러오지 못했어요." — list shows empty

### Accessibility Notes
- `TextField` must have `semanticsLabel: '상점 이름 검색'`
- Each result `InkWell`: `Semantics(label: '${merchant.name}, ${merchant.categoryLabel} 카테고리')`
- Back button: `Tooltip('뒤로')`
- Clear button: `Tooltip('검색어 지우기')`, only accessible when visible
- Focus: text field takes focus on screen entry; back button is reachable via tab order before field

### Assets
- Lucide icons: per category (same mapping as DS-001)

---

## Design Spec: DS-003 — Category Detail Screen
Version: 1.0
Status: Ready for Dev

### Overview
This screen serves two modes: (A) category browse mode — user arrived from a category grid tap, showing all benefits across their registered cards for that category; (B) merchant-specific mode — user arrived from search results or tapped a merchant within this screen, showing merchant-specific + category benefits combined. The screen must handle both modes gracefully and feel continuous between them.

### User Flow (Mode A — Category Browse)
1. User taps a category from Home grid.
2. Screen opens: shows category name in title.
3. Merchant search bar visible; no merchant selected yet.
4. Benefit list shows category-wide benefits for user's registered cards (immediate load).
5. Disclaimer shown at bottom.

### User Flow (Mode B — Merchant Selected)
1. User arrives from Search Screen (merchant pre-selected) OR taps merchant in search bar within this screen.
2. Title remains the category name; a merchant chip/tag appears under title showing selected merchant.
3. Benefit list updates to show: merchant-specific benefits first, then category-wide benefits, with visual separator.
4. Disclaimer at bottom.

### Components

**AppBar**
- `AppBar` with `backgroundColor: #FAFBFE`, `elevation: 0`
- Back button: `ArrowLeft` Lucide 24px `#1A1A2E`
- Title: category display name, Pretendard SemiBold 18px `#1A1A2E`
- No right-side actions

**Selected Merchant Chip** (Mode B only)
- Appears below AppBar, above in-screen search bar
- `Container`: height 32px, padding 8px horizontal, background `#EEF2FF`, borderRadius 16px
- Left: category icon 16px `#6C63FF`
- Text: merchant name, Pretendard Medium 13px `#6C63FF`
- Right: `X` icon 14px `#6C63FF`, taps to deselect merchant → returns to Mode A
- Row: horizontally scrollable in case merchant name is long; else just wraps

**In-Screen Merchant Search Bar**
- Full-width `TextField` style widget
- Height: 44px
- Background: `#FFFFFF`
- Border: 1px `#E5E7EB`, borderRadius 8px
- Left icon: `Search` Lucide 16px `#6B7280`
- Placeholder: "이 카테고리에서 검색", Pretendard Regular 14px `#6B7280`
- Margin: 12px horizontal, 8px vertical
- On tap: expands inline (does not navigate away), shows filtered merchant list below as an overlay or in-place replaces benefit list
- On merchant select: chip appears, benefit list updates

**Benefit Cards List**
- Widget: `ListView.builder` inside the screen body (below search bar)
- Section header if Mode B: "가맹점 혜택" label (Pretendard SemiBold 13px `#6B7280`, uppercase tracking, 16px left, 8px top) above merchant-specific cards, and "카테고리 혜택" label above category-wide cards
- Each benefit card: `Card` widget
  - `elevation: 2`
  - `color: #FFFFFF`
  - `borderRadius: 12px`
  - `margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6)`
  - Internal padding: 16px
  - Layout:
    - Row top: `[Card/Issuer name (left, expanded)] [Type badge (right)]`
    - Card/Issuer name: Pretendard SemiBold 15px `#1A1A2E`
    - Type badge: `Container` height 22px, padding 6px horizontal, borderRadius 6px
      - 신용카드: background `#EEF2FF`, text `#6C63FF`
      - 체크카드: background `#FFF0F5`, text `#FF6B9D`
      - 통신사: background `#F0FDF4`, text `#10B981`
      - Text: Pretendard Medium 11px
    - Benefit summary row (below name, 6px top margin):
      - Rate/amount: Pretendard Bold 17px `#6C63FF` — this is the hero number ("3% 할인", "최대 5,000원")
      - Rest of summary: Pretendard Regular 14px `#6B7280` inline

**Disclaimer Text**
- At bottom of list (as last `ListView` item, not fixed footer)
- Pretendard Regular 11px, `#6B7280`
- Padding: 16px horizontal, 8px top, 24px bottom
- Text: "혜택은 카드사 정책에 따라 변경될 수 있습니다. 정확한 내용은 해당 카드사에서 확인하세요."

**Empty State (no benefits)**
- Widget: centered Column inside a `SizedBox(height: 200)`
- Icon: `CreditCard` Lucide 40px `#6B7280`
- Text: "등록된 카드 중 해당 혜택이 없습니다", Pretendard Regular 14px `#6B7280`, 12px top

### Visual Specs
- Background: `#FAFBFE`
- Card surface: `#FFFFFF`
- Benefit rate color: `#6C63FF` (Primary) — this is intentional; it draws the eye to the most important number
- Typography:
  - AppBar title: Pretendard SemiBold 18px `#1A1A2E`
  - Card name: Pretendard SemiBold 15px `#1A1A2E`
  - Rate/amount: Pretendard Bold 17px `#6C63FF`
  - Benefit description: Pretendard Regular 14px `#6B7280`
  - Section headers: Pretendard SemiBold 13px `#6B7280`, letterSpacing 0.5px
  - Disclaimer: Pretendard Regular 11px `#6B7280`
- Shadows: Card elevation 2 = `BoxShadow(color: #1A1A2E0F, blurRadius: 6, offset: Offset(0, 2))`
- Merchant chip border: none, background fills identity

### States to Cover
- [x] Mode A — category benefits loaded
- [x] Mode B — merchant selected, combined results
- [x] Loading (benefits fetch): shimmer cards (3 placeholder cards)
- [x] Empty — no benefits for registered cards
- [x] Empty — no merchant found in in-screen search: show "검색 결과가 없습니다" inline below search bar
- [x] No cards registered: empty state with CTA "카드를 등록하면 혜택을 확인할 수 있어요"
- [x] Error state: snackbar retry

### Accessibility Notes
- Back button: `Tooltip('뒤로')`
- Benefit card: `Semantics(label: '${cardName}, ${typeBadge}, ${benefitSummary}')` on each card container
- Rate number: do not rely on color alone — the bold weight also differentiates
- Type badge: color + text label (never color-only)
- Disclaimer: small text (11px) is acceptable for supplemental legal text; it is not action-bearing
- Merchant chip close: `Tooltip('${merchantName} 선택 해제')`

### Assets
- Lucide icons: `CreditCard`, `Search`, `X`, `ArrowLeft`
- No issuer logos needed at this level (issuer logos appear in Provider Detail)

---

## Design Spec: DS-004 — Provider Detail Screen
Version: 1.0
Status: Ready for Dev

### Overview
The Provider Detail Screen shows full card or telecom provider details: issuer logo, card name, credit/debit badge, tier table (전월실적 → 월 한도), and benefits grouped by category. It is the authoritative reference screen — dense information, but organized clearly. Users arrive here by tapping a card in the Category Detail benefit list, or from My Cards.

### User Flow
1. User taps a benefit card in DS-003 (or a card in My Cards).
2. Provider Detail Screen opens with a push transition.
3. Header shows issuer logo area + card name + badge.
4. User scrolls to see tier table, then grouped benefits.
5. User taps back to return.

### Components

**AppBar**
- `AppBar`, `backgroundColor: #FAFBFE`, `elevation: 0`
- Back button: `ArrowLeft` Lucide 24px `#1A1A2E`
- No title in AppBar (title is in the scrollable header below)
- Optional: share icon (`Share2` Lucide 24px `#6B7280`) at right — placeholder for future

**Scrollable Header (within body, not pinned)**
- Use `CustomScrollView` with `SliverToBoxAdapter` for header + `SliverList` for rest
- Header block: `Container`, padding 20px, background `#FFFFFF`, borderRadius bottom 16px
  - Issuer logo area: `Container` 64x64px, borderRadius 12px, border 1px `#E5E7EB`, centered within a 80px-wide left section. Use `Image.network` for logo; on error, show issuer initial letter in `#6C63FF` on `#EEF2FF` background, Pretendard Bold 24px
  - Right of logo: Column
    - Card name: Pretendard Bold 20px `#1A1A2E`, maxLines 2
    - Type badge (신용/체크/통신사): same badge spec as DS-003, 8px top margin
    - Annual fee: Pretendard Regular 13px `#6B7280`, "연회비 {amount}원" or "연회비 없음", 6px top
    - Monthly limit: Pretendard Regular 13px `#6B7280`, "월 한도 {amount}원", 4px top
  - Row layout: `[Logo 80px] [Column expanded]`, crossAxisAlignment: start, 16px gap

**Tier Table**
- Section label: "전월실적 조건", Pretendard SemiBold 15px `#1A1A2E`, 20px top margin, 16px horizontal
- Widget: `Table` widget with 2 columns
  - Column 1: "전월실적", Pretendard SemiBold 13px `#6B7280`, background `#F9FAFB`
  - Column 2: "월 한도", Pretendard SemiBold 13px `#6B7280`, background `#F9FAFB`
  - Header row height: 40px
  - Data rows: alternating background `#FFFFFF` / `#F9FAFB`, height 44px
  - Data cell text: Pretendard Regular 14px `#1A1A2E`
  - Border: `TableBorder.all(color: #E5E7EB, width: 1)`, borderRadius 8px via wrapping `Container` with `ClipRRect`
  - Margin: 12px top, 16px horizontal
- If no tier data: hide section

**Benefits List (grouped by category)**
- After the tier table
- Each group:
  - Group header: `Row` — category icon 20px `#6C63FF` + category display name, Pretendard SemiBold 14px `#1A1A2E`, padding 16px horizontal, 20px top
  - Benefit items: `ListView`-equivalent items within `Column` (no nested scroll)
    - Each item: `Container`, padding 12px horizontal + 10px vertical, background `#FFFFFF`, bottom border 1px `#E5E7EB`
    - Left: benefit description, Pretendard Regular 14px `#1A1A2E`, expanded
    - Right: benefit type badge (`할인`/`캐시백`/`포인트`) + amount/rate
      - Badge: height 20px, padding 4px horizontal, borderRadius 4px
        - 할인: background `#EEF2FF`, text `#6C63FF`
        - 캐시백: background `#FFF0F5`, text `#FF6B9D`
        - 포인트: background `#FFFBEB`, text `#D97706`
      - Amount/rate: Pretendard SemiBold 14px `#6C63FF`, 4px left margin from badge

**Bottom Spacing**
- 32px bottom padding after last item

### Visual Specs
- Background: `#FAFBFE`
- Header block: `#FFFFFF` with bottom shadow `BoxShadow(color: #1A1A2E08, blurRadius: 8, offset: Offset(0, 4))`
- Typography hierarchy:
  - Card name: Pretendard Bold 20px `#1A1A2E`
  - Section headers: Pretendard SemiBold 15px `#1A1A2E`
  - Table headers: Pretendard SemiBold 13px `#6B7280`
  - Table data: Pretendard Regular 14px `#1A1A2E`
  - Benefit description: Pretendard Regular 14px `#1A1A2E`
  - Benefit amount: Pretendard SemiBold 14px `#6C63FF`
- Badge colors as defined above — consistent with DS-003

### States to Cover
- [x] Fully loaded (logo + all data)
- [x] Logo load failure (initial fallback)
- [x] No tier table (card has no 전월실적 conditions)
- [x] No benefits (should not normally occur; show "혜택 정보가 없습니다" if it does)
- [x] Loading: header shimmer (80px circle + 3 lines), tier table shimmer (2x3 grid), benefits shimmer (4 rows)
- [x] Long card name (2-line wrap allowed in header)
- [x] Many benefit groups: scroll handles this naturally

### Accessibility Notes
- Issuer logo: `Semantics(label: '${issuerName} 로고')`
- Type badge: `Semantics(label: typeBadgeText)` (e.g. "신용카드")
- Tier table: add `Semantics` on the `Table` with a summary description; each cell has `semanticsLabel`
- Benefit type badges: never color-only; always include text label
- Focus order: AppBar back → (share if present) → header name → tier table → benefit groups (top to bottom)

### Assets
- Issuer logos: network images via URL from Firestore `benefit_providers.logoUrl`; 64x64px display
- Lucide icons: category icons, `ArrowLeft`, `Share2`

---

## Design Spec: DS-005 — My Cards Screen
Version: 1.0
Status: Ready for Dev

### Overview
My Cards is the management screen for the user's registered cards. Cards are grouped into three sections: 신용카드, 체크카드, 통신사. Each row supports swipe-to-delete. An add button opens a search dialog for benefit_providers. The screen's UX job is to make card management feel safe and friction-light — adding should be fast, deleting should require confirmation.

### User Flow
1. User navigates to My Cards (from Home AppBar icon or similar entry point).
2. Lists all registered cards in sections.
3. User taps "카드 추가" — bottom sheet search dialog opens.
4. User finds and selects a card → it is added to the list instantly.
5. User swipes a card row left → delete confirmation revealed (swipe-to-delete pattern).
6. User confirms delete → row animates out.

### Components

**AppBar**
- Title: "내 카드", Pretendard SemiBold 18px `#1A1A2E`
- Back button: `ArrowLeft` Lucide 24px
- Right: `TextButton` or `IconButton` with "추가" text or `Plus` Lucide 24px `#6C63FF` — opens add bottom sheet

**Section Headers**
- `Container`, padding: 16px horizontal, 12px top, 6px bottom
- Text: Pretendard SemiBold 13px `#6B7280`
- Count badge: inline after section name — Pretendard Medium 13px `#6C63FF` (e.g. "신용카드 3")

**Card Row**
- Widget: `Dismissible` wrapping a `ListTile`-equivalent
- Row height: 68px
- Layout: `[Logo 40x40px] [Card name + issuer] [ChevronRight icon]`
  - Logo: `Container` 40x40px, borderRadius 8px, border 1px `#E5E7EB`, logo image or initial fallback
  - Card name: Pretendard SemiBold 15px `#1A1A2E`
  - Issuer name (below): Pretendard Regular 13px `#6B7280`
  - ChevronRight: `ChevronRight` Lucide 18px `#6B7280` — taps to Provider Detail
- Between rows: `Divider` 1px `#E5E7EB`, indent 72px
- Swipe-to-delete: `Dismissible(direction: DismissDirection.endToStart)`, background shows red `#EF4444` area with `Trash2` Lucide 24px white, `confirmDismiss` callback shows `AlertDialog`

**Delete Confirmation Dialog**
- `AlertDialog`:
  - Title: "카드를 삭제할까요?", Pretendard SemiBold 17px `#1A1A2E`
  - Content: "${cardName}을(를) 목록에서 제거합니다.", Pretendard Regular 14px `#6B7280`
  - Actions: "취소" (`TextButton`, `#6B7280`) + "삭제" (`TextButton`, `#EF4444`, Pretendard SemiBold)

**Empty State (no cards at all)**
- Centered in body
- Illustration area: 140x140px `Container` `#EEF2FF` borderRadius 24px (placeholder for SVG)
- Title: "아직 카드가 없어요", Pretendard SemiBold 17px `#1A1A2E`, 24px top
- Subtitle: "자주 쓰는 카드를 등록해 혜택을 확인해 보세요", Pretendard Regular 14px `#6B7280`, 8px top, 32px horizontal padding, centered
- CTA button: "카드 추가하기", same style as DS-001 empty CTA, 24px top

**Add Card Bottom Sheet**
- `DraggableScrollableSheet` or `showModalBottomSheet` with `isScrollControlled: true`
- `borderRadius: BorderRadius.vertical(top: Radius.circular(20))`
- Handle bar: 4px tall, 40px wide, `#E5E7EB`, centered, 12px top
- Title row: "카드 추가", Pretendard SemiBold 17px `#1A1A2E`, 16px from handle, 16px horizontal
- Search field (auto-focused): same style as DS-002 TextField but inside the sheet; placeholder "카드명 또는 은행명 검색"
- Results: scrollable list of `benefit_providers`, same row format as card rows but without swipe + with "추가" chip on right
  - Already-added providers: "추가됨" chip (greyed out, non-tappable)
- Max sheet height: 85% of screen height
- Min sheet height: 50% of screen height

### Visual Specs
- Background: `#FAFBFE`
- Section header: no background difference from body (subtle, text-only differentiation)
- Swipe background: `#EF4444`
- Empty state illustration: `#EEF2FF` background placeholder
- Typography as specified per component
- Row divider: `#E5E7EB` 1px

### States to Cover
- [x] Populated (all 3 sections, some empty sections hidden)
- [x] Empty (no cards at all)
- [x] One section empty (only show sections that have cards)
- [x] Add sheet open
- [x] Add sheet — search active — results shown
- [x] Add sheet — all providers already added
- [x] Swipe in progress (red background revealing)
- [x] Delete confirmation dialog
- [x] Deleting animation (item slides out + list collapses)
- [x] Adding animation: new row `AnimatedList` insertion

### Accessibility Notes
- `Dismissible`: set `secondaryBackground` with `Semantics(label: '${cardName} 삭제')`
- Add button: `Tooltip('카드 추가')`
- Card row: `Semantics(label: '${cardName}, ${issuerName}, 탭하면 상세 보기')`
- Delete dialog: focus trap within dialog; cancel gets initial focus
- Bottom sheet: `Semantics(label: '카드 추가 패널')`
- Already-added chip: `Semantics(label: '이미 추가된 카드', button: false)`

### Assets
- Lucide icons: `ArrowLeft`, `Plus`, `ChevronRight`, `Trash2`, `Search`, `CreditCard`
- Card logos: same as DS-004 logo handling

---

## Design Spec: DS-006 — Onboarding (3 Slides)
Version: 1.0
Status: Ready for Dev

### Overview
Three-slide onboarding presented to first-time users only. Skip is always visible. The onboarding must communicate value quickly — users should feel intrigued, not trained. Each slide is one clear idea with one illustration and minimal text.

### User Flow
1. First app launch: Onboarding screen appears before Home.
2. User swipes or taps "다음" to advance through 3 slides.
3. On slide 3: "다음" changes to "시작하기".
4. "시작하기" or "건너뛰기" navigates to Home (and saves onboarding-seen flag).

### Components

**Container Structure**
- `PageView` with 3 pages, `physics: BouncingScrollPhysics`
- Background: `#FAFBFE` for all slides

**Skip Button**
- `TextButton`, always visible at top-right
- Text: "건너뛰기", Pretendard Regular 14px `#6B7280`
- Padding: 16px top (safe area aware), 16px right
- Position: `Positioned` at top-right within `Stack`

**Slide Content (each slide)**
- `Column`, centered, padding 32px horizontal
- Illustration area: `Container` 240x240px, borderRadius 24px — placeholder color `#EEF2FF` (slide 1), `#FFF0F5` (slide 2), `#F0FDF4` (slide 3); insert SVG illustrations here
- Headline: Pretendard Bold 24px `#1A1A2E`, centered, 32px top margin
- Body: Pretendard Regular 15px `#6B7280`, centered, 12px top margin, line-height 1.6

**Slide 1 Content:**
- Headline: "내가 가진 카드로\n최적 혜택을"
- Body: "어디서 결제하든 내 카드 중\n가장 유리한 혜택을 바로 알려드려요."

**Slide 2 Content:**
- Headline: "카드를 등록해\n혜택을 불러오세요"
- Body: "신용카드, 체크카드, 통신사 혜택까지\n한 곳에서 확인할 수 있어요."

**Slide 3 Content:**
- Headline: "검색하고\n혜택을 찾아보세요"
- Body: "상점 이름이나 카테고리로 검색하면\n최적의 혜택이 바로 나타나요."

**Page Indicator**
- Row of 3 dots, centered, 32px above bottom CTA
- Inactive dot: 8x8px circle, `#E5E7EB`
- Active dot: `AnimatedContainer`, expands to 24x8px, borderRadius 4px, color `#6C63FF`
- Dot spacing: 6px
- Animate with `AnimatedContainer` on `currentPage` change

**Bottom CTA Button**
- `ElevatedButton`, width fill minus 32px horizontal padding, height 52px, borderRadius 26px
- Background: `#6C63FF`
- Text: "다음" (slides 1–2) / "시작하기" (slide 3)
- Text style: Pretendard SemiBold 16px white
- Bottom padding: 40px from bottom (safe area aware)
- Animate label change: `AnimatedSwitcher` with fade when transitioning slide 2 → slide 3

### Visual Specs
- Background: `#FAFBFE`
- Illustration background tints: slide-specific (see above)
- Active indicator: `#6C63FF`
- Inactive indicator: `#E5E7EB`
- CTA button: `#6C63FF`
- Typography:
  - Headline: Pretendard Bold 24px `#1A1A2E`
  - Body: Pretendard Regular 15px `#6B7280`, lineHeight 1.6
  - Skip: Pretendard Regular 14px `#6B7280`
  - CTA: Pretendard SemiBold 16px white
- Slide transition: horizontal scroll (PageView default)
- Dot animation: `duration: 250ms, curve: Curves.easeInOut`

### States to Cover
- [x] Slide 1 (initial)
- [x] Slide 2
- [x] Slide 3 (CTA label changes)
- [x] Skip tapped (any slide) → navigate to Home, save flag
- [x] "시작하기" tapped → navigate to Home, save flag
- [x] No cards registered after onboarding → Home shows empty state (handled by DS-001)

### Accessibility Notes
- `PageView` children: `Semantics(label: '온보딩 ${n}단계 / 3단계')`
- Skip button: `Semantics(label: '온보딩 건너뛰기')`
- Page indicator dots: `Semantics(label: '${n}페이지 인디케이터', selected: isActive)` on each dot
- CTA button: `Semantics(label: currentPage == 2 ? '시작하기' : '다음')`
- Illustration containers: `Semantics(image: true, label: 'Slide ${n} 일러스트')` — actual alt text TBD with final illustrations

### Assets
- Illustrations: 3 SVG files (240x240px), placeholders in color-tinted containers for now
- Font: Pretendard loaded via `pubspec.yaml` assets

---

# PART 2 — NOVA'S EXPERIENCE SPECS

---

## Experience Spec: EX-001 — Onboarding Flow
Version: 1.0
Status: Ready for Review

### Emotional Journey

**Entering state:** The user just installed Dealping. They likely feel mildly skeptical — "another app claiming to save me money." They're time-poor, not ready for a tutorial. There is low trust and mild curiosity.

**Desired exit state:** They feel clever for installing it. "Oh, this is actually simple — it just shows me the best card. I get it." They feel a quiet confidence that this app will be useful, not a burden. They tap "시작하기" with mild excitement rather than relief that it's over.

**Key moment:** The single line on Slide 1 — "내가 가진 카드로 최적 혜택을" — this phrase must land with immediacy. If the user reads it and thinks "yes, that's exactly what I want," we've won the onboarding. Everything else is supporting detail.

### Behavioral Design Notes

- **Hick's Law** applied: three slides maximum. Each slide carries one concept, one action. No choices except "next" or "skip." We do not overwhelm with features.
- **Progress is the reward**: the pill-shaped expanding indicator gives a visceral sense of movement. Users can feel themselves advancing. This reduces drop-off at slides 2–3.
- **Skip as safety net, not invitation**: "건너뛰기" is visible but subdued (`#6B7280`, regular weight). It signals "you can leave if you want" without shouting it. We do not want to prime users to skip — we want them to feel comfortable that they *could*, which paradoxically makes them less likely to.
- **Friction intentionally kept — card registration is NOT in onboarding**: We deliberately do not ask users to add cards during onboarding. Asking for data before demonstrating value is a trust violation. The app must first prove it understands what the user wants. Card registration belongs on the Home empty state, after the value proposition has been absorbed.
- **Anxiety reduction — "등록"**: Korean users may be sensitive about registering financial products. The word "카드를 등록" may trigger mild concern. Body copy on Slide 2 should immediately follow with "혜택 정보만 확인해요" or similar reassurance. The card number is never asked — clarify this implicitly through copy tone (not a form, not sensitive data).

### Motion & Interaction

- **Slide transition**: PageView horizontal scroll with `BouncingScrollPhysics`. Natural, familiar, gesture-native. Avoids feeling like a "presentation" which could trigger "skip" instinct. Duration: physics-driven (user-controlled), not timed.
- **Page indicator — dot to pill**: `AnimatedContainer` width: 8→24px, duration: 250ms, `Curves.easeInOut`. This is the only animation on screen during a slide-change besides the content scroll. One clear signal, no clutter.
- **CTA label transition (slide 2→3)**: `AnimatedSwitcher` with a 200ms upward `SlideTransition` (new label slides up in, old label slides up out). Signals "something changed" — the user is at the final moment. Subtle but meaningful.
- **"시작하기" tap**: Brief button scale-down (0.95 scale, 100ms) then immediate `Navigator.pushReplacement` to Home. No splash screen. The tap should feel conclusive — a door opening, not a loading state.
- **Illustration entrance per slide**: On each `PageView.onPageChanged`, trigger a `FadeTransition` (0→1, 400ms, `Curves.easeOut`) on the illustration container. Content does not scroll in with the page — it fades up gently. This separates the "swipe" gesture from the "content appearing" moment, creating a micro-pause of attention.

### Visual Direction

- **Mood:** Calm, clever, trustworthy
- **Slide 1 illustration tint** (`#EEF2FF` — cool light purple): evokes the Primary brand color, sets the product tone immediately
- **Slide 2 tint** (`#FFF0F5` — soft pink): warmer, suggests "your personal cards," feeling of personalization
- **Slide 3 tint** (`#F0FDF4` — pale green): success/action tint, "you're ready to go" — reinforces positive anticipation
- **Color arc intentional**: cool brand → warm personal → success green. Emotional arc: "here's the product" → "here's your role" → "here's the reward." This is not accidental decoration; it is sequenced emotional priming.
- **No gradient backgrounds**: gradients would feel over-produced. The product is functional-first; the illustration area carries the color moment. Rest of the slide stays `#FAFBFE`.

### Validation Plan

- **Metric to watch:** Slide completion rate per step (slide 1 → 2 → 3 → Home). Track where users drop off or skip.
- **Secondary metric:** Time-to-first-card-addition after onboarding. If users immediately add a card after onboarding, value communication succeeded. If they don't add a card within the first session, consider onboarding copy iteration.
- **A/B hypothesis:** Variant A (current) — no card registration in onboarding. Variant B — add a minimal "add your first card" step after Slide 3. Hypothesis: Variant A produces higher D7 retention and similar or better card-add rates because users who willingly return to add cards are more engaged than those nudged to add during onboarding.

---

## Experience Spec: EX-002 — Finding the Best Card for a Merchant
Version: 1.0
Status: Ready for Review

### Emotional Journey

**Entering state:** The user is physically at a merchant (or about to pay online). They have 15–30 seconds, maybe less. They feel the mild pressure of a checkout moment. They may feel slightly anxious — "I should know which card to use, I never remember." There is a task urgency that is low-stakes but emotionally activating (loss aversion: "I don't want to miss out on a benefit I could have had").

**Desired exit state:** They feel certain and slightly smug. "Ah, Shinhan Card 3% — nice." They put away the right card with confidence. The app has delivered a single, clear answer. They feel the app has made them financially smarter without requiring any effort.

**Key moment:** The moment the benefit rate appears on screen in `#6C63FF` bold — "3% 할인" or "최대 5,000원" — in large text. This is the app's one job. Everything else is infrastructure for this moment.

### Behavioral Design Notes

- **Loss aversion as motivator (handled responsibly)**: The user's core fear is "I'm leaving money on the table." We don't amplify this anxiety — we resolve it. The app does not say "you could be losing X." It simply shows the best benefit. Resolution, not alarm.
- **Cognitive load minimization**: At checkout time, the user has a high cognitive load (what to order, how to pay, people waiting). The screen must answer the question in the fewest possible visual steps. The benefit rate must be scannable in under 2 seconds. This is why the rate is Bold 17px in Primary — it is the only thing on the card that truly needs to be read.
- **Progressive disclosure — merchant vs. category**: Users often don't know the exact merchant name. Category browse is the fallback. Mode A (category benefits) shows "good enough" answers when the merchant isn't known. Mode B (merchant-specific) shows the optimal answer when it is. The design must make Mode A feel valuable, not like a failure state — it is the most common path for users still learning the app.
- **Trust signals in results**: Each benefit card shows the card's exact name (never an abbreviation), the type badge, and a clear benefit summary. Users need to see their actual card name to feel confident this is their card — not a generic recommendation.
- **Friction intentionally removed**: No login wall at benefit query time. No "are you sure?" No modal. User searches → results appear. The fastest path to an answer is the design goal.
- **Anxiety about "is this accurate?"**: The disclaimer at the bottom of Category Detail ("혜택은 카드사 정책에 따라 변경될 수 있습니다") addresses the honest limitation of the data without undermining confidence in the result. It is placed after the results (not before), so it contextualizes rather than preempts trust.

### Motion & Interaction

- **Search field auto-focus**: Keyboard appears immediately when Search Screen opens. This communicates "you're already in the right place, just type." No tap required to begin. Saves 1–2 seconds at checkout.
- **Real-time filtering (debounce 300ms)**: Results update as the user types. The list does not flash or jump — use `AnimatedList` or `setState` with stable keys so items shift smoothly rather than re-render from scratch. The experience should feel like the list is alive and responsive, not like a database query.
- **Benefit card entry animation (Category Detail)**: When the benefit list loads, cards stagger in from bottom: `SlideTransition` upward, 200ms each, 80ms stagger delay between cards. This is the moment of payoff — the answer arriving — and motion signals "here it comes." Maximum 5 cards stagger; remaining cards appear without animation to avoid long waits.
- **Merchant chip appearance (mode switch)**: When a merchant is selected and the screen shifts from Mode A to Mode B, the chip appears with a `FadeTransition` (150ms) and the benefit list crossfades (`AnimatedSwitcher`, 200ms). The transition signals "the result just got more specific for you" — a moment of personalization.
- **Rate number — no animation**: The benefit rate itself (`#6C63FF` Bold 17px) does NOT animate in a special way. It appears with the card. The visual weight alone carries the moment. Animating the number would feel gimmicky and delay the scan time.
- **Loading during benefit fetch**: Shimmer skeleton cards — same dimensions as real cards. The shimmer moves left-to-right. This signals "content is forming," which is more reassuring than a spinner which signals "waiting for something external." Duration expectation is set correctly: 3 shimmer cards implies "a few results are coming," not "a massive list."

### Visual Direction

- **Mood:** Precise, warm, immediate
- **Key visual decision — rate in Primary**: `#6C63FF` on `#FFFFFF` achieves 5.4:1 contrast (AA pass). The purple-blue reads as "authoritative answer" rather than "marketing highlight." It is calm and confident, not alarming. This contrasts with `#FF6B9D` (Secondary/coral) which is reserved for type badges — a visual separation between "what the benefit is" and "who provides it."
- **Card elevation at checkout moment**: The `elevation: 2` on benefit cards creates a physical sense of the cards as "objects you can pick up and use." This is subtle but psychologically grounded — cards feel like real choices, not list items.
- **White screen for search (vs. #FAFBFE for home)**: The Search Screen uses pure `#FFFFFF`. At checkout urgency, pure white feels faster and more direct. `#FAFBFE` is a rest-state color; white is an action-state color.
- **No illustrations at checkout**: Category Detail and Search are zero-illustration screens. Illustrations are for orienting moments (onboarding, empty states). At task execution time, every pixel serves the answer.

### Validation Plan

- **Primary metric:** Time from app-open to first benefit card visible (target: under 10 seconds for a returning user who knows the merchant name).
- **Secondary metric:** Session length at merchant-search flows. Too short = user found the answer (good). Too long = user is confused or browsing (investigate).
- **Return rate metric:** "Same-merchant re-query rate" — do users search the same merchant repeatedly? If yes, they're using the app as a live reference tool (strong signal of habit formation). This is the desired behavior.
- **A/B hypothesis — benefit card layout:** Variant A (current) — rate in Primary bold left-aligned below card name. Variant B — rate in Primary bold right-aligned with a colored accent bar on left edge of card. Hypothesis: Variant A is faster to scan because the rate appears predictably under the card name in reading order. Variant B may be more visually striking but could add 0.5–1 second scan time.
- **Drop-off signal:** If users arrive at Category Detail with a merchant pre-selected (Mode B) and then back out immediately, the benefit list is not answering their question. Investigate whether merchant aliases in Firestore are comprehensive enough (a data problem, not a design problem — flag to PM).
