const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// ── Firebase 초기화 ──────────────────────────────────────────────────────────
const serviceAccount = require('./service-account.json');
admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });
const db = admin.firestore();

// ── 카테고리 데이터 ──────────────────────────────────────────────────────────
const CATEGORIES = [
  { id: 'cat_cafe_food',    name: '카페/푸드',   icon: 'coffee',           sort_order: 0 },
  { id: 'cat_convenience',  name: '편의점/마트', icon: 'store',            sort_order: 1 },
  { id: 'cat_online',       name: '쇼핑/온라인', icon: 'shopping_cart',    sort_order: 2 },
  { id: 'cat_subscription', name: '구독/배달',   icon: 'delivery_dining',  sort_order: 3 },
  { id: 'cat_transport',    name: '교통/주유',   icon: 'local_gas_station',sort_order: 4 },
  { id: 'cat_life',         name: '생활/기타',   icon: 'apps',             sort_order: 5 },
];

// ── 카드사 코드 매핑 ─────────────────────────────────────────────────────────
const ISSUER_CODE_MAP = {
  '신한카드': 'shinhan',
  '삼성카드': 'samsung',
  '현대카드': 'hyundai',
  '우리카드': 'woori',
  'KB국민카드': 'kb',
  '하나카드': 'hana',
  'NH농협카드': 'nh',
  '롯데카드': 'lotte',
  'BC카드': 'bc',
  'IBK기업은행': 'ibk',
  '카카오뱅크': 'kakaobank',
  '토스뱅크': 'tossbank',
  'Kbank': 'kbank',
  'K뱅크': 'kbank',
};

// ── 혜택 파싱 함수 ───────────────────────────────────────────────────────────
function parseBenefitRate(description) {
  const match = description.match(/(\d+(?:\.\d+)?)\s*%/);
  return match ? parseFloat(match[1]) : 0;
}

function parseBenefitType(description) {
  if (description.includes('캐시백')) return 'cashback';
  if (description.includes('마일리지') || description.includes('마일') || description.includes('포인트') || description.includes('적립')) return 'point';
  return 'discount';
}

function parseBenefitFixed(description) {
  const literMatch = description.match(/리터당\s*(\d+)원/);
  if (literMatch) return parseInt(literMatch[1]);
  const wonMatch = description.match(/(\d{1,3}(?:,\d{3})*)\s*원\s*(?:할인|캐시백|적립)/);
  if (wonMatch) return parseInt(wonMatch[1].replace(/,/g, ''));
  return null;
}

function getIssuerCode(issuerName) {
  return ISSUER_CODE_MAP[issuerName] || issuerName.toLowerCase().replace(/\s/g, '_');
}

// ── 카테고리 업로드 ──────────────────────────────────────────────────────────
async function seedCategories() {
  console.log('\n📂 카테고리 업로드 중...');
  const batch = db.batch();
  for (const cat of CATEGORIES) {
    const ref = db.collection('categories').doc(cat.id);
    batch.set(ref, {
      name: cat.name,
      icon: cat.icon,
      sort_order: cat.sort_order,
      is_active: true,
    });
  }
  await batch.commit();
  console.log(`✅ 카테고리 ${CATEGORIES.length}개 완료`);
}

// ── 카드 업로드 ──────────────────────────────────────────────────────────────
async function seedCards(cards) {
  console.log('\n💳 카드/혜택 업로드 중...');
  let cardCount = 0;
  let benefitCount = 0;

  for (const card of cards) {
    const issuerCode = getIssuerCode(card.issuer);

    // benefit_providers 문서
    const providerRef = db.collection('benefit_providers').doc(card.id);
    await providerRef.set({
      name: card.card_name,
      provider_type: 'card',
      card_type: 'credit',
      issuer: issuerCode,
      issuer_name: card.issuer,
      annual_fee: card.annual_fee || 0,
      image_url: card.image_url || '',
      is_active: true,
      created_at: admin.firestore.FieldValue.serverTimestamp(),
      updated_at: admin.firestore.FieldValue.serverTimestamp(),
    });

    // tiers 서브컬렉션 (전월실적 있는 경우)
    if (card.min_spending > 0) {
      await providerRef.collection('tiers').add({
        min_spend: card.min_spending,
        max_spend: null,
        monthly_discount_limit: card.max_monthly_benefit || 0,
        description: `전월실적 ${Math.round(card.min_spending / 10000)}만원 이상`,
      });
    }

    // benefits 서브컬렉션
    if (card.benefits && card.benefits.length > 0) {
      const batch = db.batch();
      for (const benefit of card.benefits) {
        const rate = parseBenefitRate(benefit.description);
        const type = parseBenefitType(benefit.description);
        const fixed = rate === 0 ? parseBenefitFixed(benefit.description) : null;

        const benefitRef = providerRef.collection('benefits').doc();
        batch.set(benefitRef, {
          category_id: benefit.category_id,
          merchant_id: benefit.merchant_id || null,
          benefit_type: type,
          benefit_rate: rate,
          benefit_fixed: fixed,
          benefit_description: benefit.description,
          conditions: benefit.conditions || '',
          is_active: true,
        });
        benefitCount++;
      }
      await batch.commit();
    }

    cardCount++;
    console.log(`  ✅ ${card.card_name}`);
  }

  console.log(`\n✅ 카드 ${cardCount}개, 혜택 ${benefitCount}개 완료`);
}

// ── 가맹점 업로드 ─────────────────────────────────────────────────────────────
async function seedMerchants(merchants) {
  console.log('\n🏪 가맹점 업로드 중...');
  const batch = db.batch();
  for (const m of merchants) {
    const ref = db.collection('merchants').doc(m.id);
    batch.set(ref, {
      name: m.name,
      category_id: m.category_id,
      aliases: m.aliases || [],
      is_franchise: true,
      sort_order: m.sort_order || 0,
      is_active: true,
    });
  }
  await batch.commit();
  console.log(`✅ 가맹점 ${merchants.length}개 완료`);
}

// ── 메인 ─────────────────────────────────────────────────────────────────────
async function main() {
  console.log('🚀 DealPing Firestore 시드 시작\n');

  const cardsPath = path.join(__dirname, 'data', 'cards.json');
  const merchantsPath = path.join(__dirname, 'data', 'merchants.json');

  if (!fs.existsSync(cardsPath)) {
    console.error('❌ scripts/data/cards.json 파일이 없습니다.');
    process.exit(1);
  }

  const cards = JSON.parse(fs.readFileSync(cardsPath, 'utf8'));
  console.log(`📋 총 카드 ${cards.length}개 발견`);

  await seedCategories();
  await seedCards(cards);

  if (fs.existsSync(merchantsPath)) {
    const merchants = JSON.parse(fs.readFileSync(merchantsPath, 'utf8'));
    console.log(`📋 총 가맹점 ${merchants.length}개 발견`);
    await seedMerchants(merchants);
  }

  console.log('\n🎉 시드 완료!');
  process.exit(0);
}

main().catch(err => {
  console.error('❌ 오류:', err);
  process.exit(1);
});
