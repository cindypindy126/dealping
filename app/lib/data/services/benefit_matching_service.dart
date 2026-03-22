import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../repositories/benefit_provider_repository.dart';

class BenefitMatchingService {
  final BenefitProviderRepository _providerRepo;

  BenefitMatchingService(this._providerRepo);

  Future<List<MatchedBenefit>> matchBenefits({
    required List<String> providerIds,
    required String categoryId,
    String? merchantId,
  }) async {
    if (providerIds.isEmpty) return [];

    // Parallel fetch: all providers and their benefits simultaneously
    final futures = providerIds.map((id) async {
      final results = await Future.wait([
        _providerRepo.getById(id),
        _providerRepo.getBenefits(id),
      ]);
      return (provider: results[0] as BenefitProvider?, benefits: results[1] as List<Benefit>);
    });

    final providerData = await Future.wait(futures);
    final matched = <MatchedBenefit>[];

    for (final data in providerData) {
      final provider = data.provider;
      if (provider == null) continue;

      for (final benefit in data.benefits) {
        if (!benefit.isActive) continue;
        if (benefit.categoryId != categoryId && benefit.categoryId != 'cat_all') continue;

        final isCategoryWide = benefit.merchantId == null;
        final isMerchantMatch = merchantId != null && benefit.merchantId == merchantId;

        if (isCategoryWide || isMerchantMatch) {
          matched.add(MatchedBenefit(
            provider: provider,
            benefit: benefit,
            isMerchantSpecific: isMerchantMatch,
          ));
        }
      }
    }

    matched.sort((a, b) {
      if (a.isMerchantSpecific && !b.isMerchantSpecific) return -1;
      if (!a.isMerchantSpecific && b.isMerchantSpecific) return 1;
      return b.benefit.benefitRate.compareTo(a.benefit.benefitRate);
    });

    return matched;
  }
}

final benefitMatchingServiceProvider = Provider<BenefitMatchingService>((ref) {
  return BenefitMatchingService(ref.watch(benefitProviderRepositoryProvider));
});
