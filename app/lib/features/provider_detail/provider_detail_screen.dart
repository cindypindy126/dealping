import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/models.dart';
import '../../data/services/mock_data_service.dart';
import '../../shared/widgets/provider_type_badge.dart';

class ProviderDetailScreen extends StatelessWidget {
  final String providerId;

  const ProviderDetailScreen({super.key, required this.providerId});

  @override
  Widget build(BuildContext context) {
    final provider = MockDataService.getProvider(providerId);
    if (provider == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('카드 정보'),
        ),
        body: const Center(child: Text('카드 정보를 찾을 수 없습니다.')),
      );
    }

    final tiers = MockDataService.getTiersForProvider(providerId);
    final benefits = MockDataService.getBenefits(providerId);

    // Group benefits by category
    final Map<String, List<Benefit>> grouped = {};
    for (final b in benefits) {
      grouped.putIfAbsent(b.categoryId, () => []).add(b);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(provider.name, style: AppTextStyles.titleMedium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(provider.issuerName,
                        style: AppTextStyles.bodySmall),
                    const SizedBox(height: 4),
                    Text(provider.name,
                        style: AppTextStyles.headlineMedium),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ProviderTypeBadge(
                          providerType: provider.providerType,
                          cardType: provider.cardType,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          provider.annualFee == 0
                              ? '연회비 없음'
                              : '연회비 ${_formatKrw(provider.annualFee)}원',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tier section
            if (tiers.isNotEmpty) ...[
              Text('전월실적 구간별 혜택',
                  style: AppTextStyles.titleMedium
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1.5),
                    },
                    border: TableBorder(
                      horizontalInside: BorderSide(
                          color: AppColors.border.withAlpha(120), width: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(20),
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                        ),
                        children: [
                          _tableHeader('전월실적'),
                          _tableHeader('월 할인 한도'),
                        ],
                      ),
                      ...tiers.map((tier) => TableRow(
                            children: [
                              _tableCell(tier.description),
                              _tableCell(
                                  '${_formatKrw(tier.monthlyDiscountLimit)}원'),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Benefits list
            Text('전체 혜택 목록',
                style: AppTextStyles.titleMedium
                    .copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),

            ...grouped.entries.map((entry) {
              final catName =
                  MockDataService.getCategory(entry.key)?.name ?? entry.key;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(catName,
                        style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600)),
                  ),
                  ...entry.value.map((b) => _BenefitListTile(benefit: b)),
                  const SizedBox(height: 16),
                ],
              );
            }),

            const SizedBox(height: 8),
            Text(
              '* 상기 혜택은 전월실적 및 이용 조건에 따라 달라질 수 있습니다.',
              style:
                  AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _tableHeader(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(text,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary)),
      );

  Widget _tableCell(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(text, style: AppTextStyles.bodySmall),
      );

  String _formatKrw(int amount) {
    final str = amount.toString();
    final buf = StringBuffer();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buf.write(',');
      buf.write(str[i]);
    }
    return buf.toString();
  }
}

class _BenefitListTile extends StatelessWidget {
  final Benefit benefit;
  const _BenefitListTile({required this.benefit});

  @override
  Widget build(BuildContext context) {
    final rateLabel = benefit.benefitRate > 0
        ? '${benefit.benefitRate % 1 == 0 ? benefit.benefitRate.toInt() : benefit.benefitRate}%'
        : '';

    Color badgeColor;
    switch (benefit.benefitType) {
      case 'cashback':
        badgeColor = AppColors.cashbackBadge;
      case 'point':
        badgeColor = AppColors.pointBadge;
      default:
        badgeColor = AppColors.discountBadge;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(benefit.benefitDescription,
                    style: AppTextStyles.bodyMedium),
                if (benefit.conditions.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(benefit.conditions,
                      style: AppTextStyles.bodySmall),
                ],
                if (benefit.merchantId != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '가맹점: ${MockDataService.getMerchant(benefit.merchantId!)?.name ?? benefit.merchantId}',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.secondary),
                  ),
                ],
              ],
            ),
          ),
          if (rateLabel.isNotEmpty) ...[
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: badgeColor.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: badgeColor.withAlpha(80)),
              ),
              child: Text(rateLabel,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: badgeColor)),
            ),
          ],
        ],
      ),
    );
  }
}
