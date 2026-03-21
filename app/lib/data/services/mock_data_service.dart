import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';

/// Provides all mock data for Phase 3 development (before Firebase is ready).
class MockDataService {
  MockDataService._();

  // ─── Categories ───────────────────────────────────────────────────────────

  static final List<Category> categories = [
    const Category(
        id: 'cat_cafe_food', name: '카페/푸드', icon: 'coffee', sortOrder: 0),
    const Category(
        id: 'cat_convenience', name: '편의점/마트', icon: 'store', sortOrder: 1),
    const Category(
        id: 'cat_online', name: '쇼핑/온라인', icon: 'shopping_cart', sortOrder: 2),
    const Category(
        id: 'cat_subscription', name: '구독/배달', icon: 'delivery_dining', sortOrder: 3),
    const Category(
        id: 'cat_transport', name: '교통/주유', icon: 'local_gas_station', sortOrder: 4),
    const Category(
        id: 'cat_life', name: '생활/기타', icon: 'apps', sortOrder: 5),
  ];

  // ─── Merchants ────────────────────────────────────────────────────────────

  static final List<Merchant> merchants = [
    const Merchant(
        id: 'mer_starbucks',
        name: '스타벅스',
        categoryId: 'cat_cafe_food',
        aliases: ['스벅', 'STARBUCKS'],
        isFranchise: true,
        sortOrder: 0),
    const Merchant(
        id: 'mer_ediya',
        name: '이디야커피',
        categoryId: 'cat_cafe_food',
        aliases: ['이디야', 'EDIYA'],
        isFranchise: true,
        sortOrder: 1),
    const Merchant(
        id: 'mer_gs25',
        name: 'GS25',
        categoryId: 'cat_convenience',
        aliases: ['GS 25', 'GS편의점'],
        isFranchise: true,
        sortOrder: 0),
    const Merchant(
        id: 'mer_cu',
        name: 'CU',
        categoryId: 'cat_convenience',
        aliases: ['씨유'],
        isFranchise: true,
        sortOrder: 1),
    const Merchant(
        id: 'mer_sk_energy',
        name: 'SK에너지',
        categoryId: 'cat_transport',
        aliases: ['SK주유소', 'SK에너지주유소'],
        isFranchise: true,
        sortOrder: 0),
    const Merchant(
        id: 'mer_gs_caltex',
        name: 'GS칼텍스',
        categoryId: 'cat_transport',
        aliases: ['GS주유소'],
        isFranchise: true,
        sortOrder: 1),
    const Merchant(
        id: 'mer_baemin',
        name: '배달의민족',
        categoryId: 'cat_cafe_food',
        aliases: ['배민', 'BAEMIN'],
        isFranchise: false,
        sortOrder: 0),
    const Merchant(
        id: 'mer_coupang',
        name: '쿠팡',
        categoryId: 'cat_online',
        aliases: ['COUPANG'],
        isFranchise: false,
        sortOrder: 0),
  ];

  // ─── BenefitProviders ─────────────────────────────────────────────────────

  static final List<BenefitProvider> providers = [
    const BenefitProvider(
      id: 'prov_shinhan_deepdream',
      name: 'Deep Dream',
      providerType: 'card',
      cardType: 'credit',
      issuer: 'shinhan',
      issuerName: '신한카드',
      annualFee: 0,
    ),
    const BenefitProvider(
      id: 'prov_woori_untact',
      name: '언택트',
      providerType: 'card',
      cardType: 'credit',
      issuer: 'woori',
      issuerName: '우리카드',
      annualFee: 0,
    ),
    const BenefitProvider(
      id: 'prov_kb_tantandaero',
      name: '탄탄대로',
      providerType: 'card',
      cardType: 'debit',
      issuer: 'kb',
      issuerName: 'KB국민카드',
      annualFee: 0,
    ),
    const BenefitProvider(
      id: 'prov_hyundai_m',
      name: 'M카드',
      providerType: 'card',
      cardType: 'credit',
      issuer: 'hyundai',
      issuerName: '현대카드',
      annualFee: 10000,
    ),
    const BenefitProvider(
      id: 'prov_lgu',
      name: 'LG U+',
      providerType: 'telecom',
      cardType: null,
      issuer: 'lgu',
      issuerName: 'LG U+',
      annualFee: 0,
    ),
  ];

  // ─── Tiers (per provider) ─────────────────────────────────────────────────

  static final Map<String, List<Tier>> tiers = {
    'prov_shinhan_deepdream': [
      const Tier(
          id: 'tier_sd_1',
          minSpend: 300000,
          maxSpend: 500000,
          monthlyDiscountLimit: 5000,
          description: '전월실적 30만원 이상'),
      const Tier(
          id: 'tier_sd_2',
          minSpend: 500000,
          maxSpend: 1000000,
          monthlyDiscountLimit: 10000,
          description: '전월실적 50만원 이상'),
      const Tier(
          id: 'tier_sd_3',
          minSpend: 1000000,
          monthlyDiscountLimit: 20000,
          description: '전월실적 100만원 이상'),
    ],
    'prov_woori_untact': [
      const Tier(
          id: 'tier_wu_1',
          minSpend: 200000,
          maxSpend: 500000,
          monthlyDiscountLimit: 3000,
          description: '전월실적 20만원 이상'),
      const Tier(
          id: 'tier_wu_2',
          minSpend: 500000,
          monthlyDiscountLimit: 8000,
          description: '전월실적 50만원 이상'),
    ],
    'prov_kb_tantandaero': [
      const Tier(
          id: 'tier_kb_1',
          minSpend: 300000,
          maxSpend: 500000,
          monthlyDiscountLimit: 5000,
          description: '전월실적 30만원 이상'),
      const Tier(
          id: 'tier_kb_2',
          minSpend: 500000,
          monthlyDiscountLimit: 12000,
          description: '전월실적 50만원 이상'),
    ],
    'prov_hyundai_m': [
      const Tier(
          id: 'tier_hm_1',
          minSpend: 400000,
          maxSpend: 700000,
          monthlyDiscountLimit: 7000,
          description: '전월실적 40만원 이상'),
      const Tier(
          id: 'tier_hm_2',
          minSpend: 700000,
          monthlyDiscountLimit: 15000,
          description: '전월실적 70만원 이상'),
    ],
    'prov_lgu': [
      const Tier(
          id: 'tier_lgu_1',
          minSpend: 0,
          monthlyDiscountLimit: 5000,
          description: '실적 무관'),
    ],
  };

  // ─── Benefits ─────────────────────────────────────────────────────────────

  static final Map<String, List<Benefit>> benefits = {
    'prov_shinhan_deepdream': [
      const Benefit(
        id: 'ben_sd_1',
        categoryId: 'cat_cafe_food',
        merchantId: 'mer_starbucks',
        benefitType: 'discount',
        benefitRate: 20,
        benefitDescription: '스타벅스 20% 할인',
        conditions: '건당 5,000원 이상 결제 시',
        isActive: true,
      ),
      const Benefit(
        id: 'ben_sd_2',
        categoryId: 'cat_cafe_food',
        merchantId: null,
        benefitType: 'discount',
        benefitRate: 10,
        benefitDescription: '모든 카페 10% 할인',
        conditions: '전월실적 30만원 이상',
        isActive: true,
      ),
      const Benefit(
        id: 'ben_sd_3',
        categoryId: 'cat_online',
        merchantId: 'mer_coupang',
        benefitType: 'cashback',
        benefitRate: 5,
        benefitDescription: '쿠팡 5% 캐시백',
        conditions: '',
        isActive: true,
      ),
    ],
    'prov_woori_untact': [
      const Benefit(
        id: 'ben_wu_1',
        categoryId: 'cat_convenience',
        merchantId: null,
        benefitType: 'discount',
        benefitRate: 5,
        benefitDescription: '모든 편의점 5% 할인',
        conditions: '전월실적 20만원 이상',
        isActive: true,
      ),
      const Benefit(
        id: 'ben_wu_2',
        categoryId: 'cat_cafe_food',
        merchantId: 'mer_ediya',
        benefitType: 'discount',
        benefitRate: 10,
        benefitDescription: '이디야커피 10% 할인',
        conditions: '',
        isActive: true,
      ),
      const Benefit(
        id: 'ben_wu_3',
        categoryId: 'cat_cafe_food',
        merchantId: 'mer_baemin',
        benefitType: 'discount',
        benefitRate: 7,
        benefitDescription: '배달의민족 7% 할인',
        conditions: '월 2회 한정',
        isActive: true,
      ),
    ],
    'prov_kb_tantandaero': [
      const Benefit(
        id: 'ben_kb_1',
        categoryId: 'cat_convenience',
        merchantId: 'mer_gs25',
        benefitType: 'cashback',
        benefitRate: 7,
        benefitDescription: 'GS25 7% 캐시백',
        conditions: '전월실적 30만원 이상',
        isActive: true,
      ),
      const Benefit(
        id: 'ben_kb_2',
        categoryId: 'cat_cafe_food',
        merchantId: null,
        benefitType: 'discount',
        benefitRate: 5,
        benefitDescription: '모든 카페 5% 할인',
        conditions: '',
        isActive: true,
      ),
      const Benefit(
        id: 'ben_kb_3',
        categoryId: 'cat_transport',
        merchantId: null,
        benefitType: 'discount',
        benefitRate: 3,
        benefitDescription: '모든 주유 리터당 30원 할인',
        conditions: '전월실적 50만원 이상',
        isActive: true,
      ),
    ],
    'prov_hyundai_m': [
      const Benefit(
        id: 'ben_hm_1',
        categoryId: 'cat_transport',
        merchantId: null,
        benefitType: 'discount',
        benefitRate: 5,
        benefitDescription: '모든 주유 5% 할인',
        conditions: '전월실적 40만원 이상',
        isActive: true,
      ),
      const Benefit(
        id: 'ben_hm_2',
        categoryId: 'cat_transport',
        merchantId: 'mer_sk_energy',
        benefitType: 'discount',
        benefitRate: 10,
        benefitDescription: 'SK에너지 10% 할인',
        conditions: '전월실적 40만원 이상',
        isActive: true,
      ),
      const Benefit(
        id: 'ben_hm_3',
        categoryId: 'cat_cafe_food',
        merchantId: null,
        benefitType: 'point',
        benefitRate: 2,
        benefitDescription: '음식점 2% M포인트 적립',
        conditions: '',
        isActive: true,
      ),
    ],
    'prov_lgu': [
      const Benefit(
        id: 'ben_lgu_1',
        categoryId: 'cat_cafe_food',
        merchantId: null,
        benefitType: 'discount',
        benefitRate: 5,
        benefitDescription: '모든 카페 5% 할인',
        conditions: 'LG U+ 요금제 가입자',
        isActive: true,
      ),
      const Benefit(
        id: 'ben_lgu_2',
        categoryId: 'cat_convenience',
        merchantId: 'mer_cu',
        benefitType: 'discount',
        benefitRate: 5,
        benefitDescription: 'CU 5% 할인',
        conditions: 'LG U+ 요금제 가입자',
        isActive: true,
      ),
    ],
  };

  // ─── Lookup helpers ───────────────────────────────────────────────────────

  static BenefitProvider? getProvider(String id) {
    try {
      return providers.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  static Category? getCategory(String id) {
    try {
      return categories.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  static Merchant? getMerchant(String id) {
    try {
      return merchants.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<Merchant> getMerchantsForCategory(String categoryId) {
    return merchants.where((m) => m.categoryId == categoryId).toList();
  }

  static List<Benefit> getBenefits(String providerId) {
    return benefits[providerId] ?? [];
  }

  static List<Tier> getTiersForProvider(String providerId) {
    return tiers[providerId] ?? [];
  }

  /// Match benefits from a set of registered provider IDs.
  static List<MatchedBenefit> matchBenefits({
    required List<String> registeredProviderIds,
    required String categoryId,
    String? merchantId,
  }) {
    final results = <MatchedBenefit>[];

    for (final providerId in registeredProviderIds) {
      final provider = getProvider(providerId);
      if (provider == null || !provider.isActive) continue;

      final provBenefits = getBenefits(providerId);
      for (final benefit in provBenefits) {
        if (!benefit.isActive) continue;
        if (benefit.categoryId != categoryId) continue;

        final isCategoryWide = benefit.merchantId == null;
        final isMerchantMatch =
            merchantId != null && benefit.merchantId == merchantId;

        if (isCategoryWide || isMerchantMatch) {
          results.add(MatchedBenefit(
            provider: provider,
            benefit: benefit,
            isMerchantSpecific: isMerchantMatch,
          ));
        }
      }
    }

    results.sort((a, b) {
      if (a.isMerchantSpecific && !b.isMerchantSpecific) return -1;
      if (!a.isMerchantSpecific && b.isMerchantSpecific) return 1;
      return b.benefit.benefitRate.compareTo(a.benefit.benefitRate);
    });

    return results;
  }
}

// ─── Riverpod providers ───────────────────────────────────────────────────────

final mockCategoriesProvider = Provider<List<Category>>((ref) {
  return MockDataService.categories;
});

final mockMerchantsProvider = Provider<List<Merchant>>((ref) {
  return MockDataService.merchants;
});

final mockProvidersProvider = Provider<List<BenefitProvider>>((ref) {
  return MockDataService.providers;
});
