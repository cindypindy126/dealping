import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/models.dart';
import 'provider_type_badge.dart';

class BenefitCard extends StatelessWidget {
  final MatchedBenefit matchedBenefit;
  final VoidCallback? onTap;

  const BenefitCard({
    super.key,
    required this.matchedBenefit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final provider = matchedBenefit.provider;
    final benefit = matchedBenefit.benefit;

    final rateLabel = benefit.benefitRate > 0
        ? '${benefit.benefitRate % 1 == 0 ? benefit.benefitRate.toInt() : benefit.benefitRate}% ${_typeLabel(benefit.benefitType)}'
        : benefit.benefitFixed != null
            ? '${_formatKrw(benefit.benefitFixed!)} 할인'
            : benefit.benefitDescription;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(provider.issuerName,
                            style: AppTextStyles.bodySmall),
                        const SizedBox(height: 2),
                        Text(provider.name,
                            style: AppTextStyles.titleMedium),
                      ],
                    ),
                  ),
                  ProviderTypeBadge(
                    providerType: provider.providerType,
                    cardType: provider.cardType,
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right,
                      size: 20, color: AppColors.textSecondary),
                ],
              ),
              const SizedBox(height: 12),
              Text(benefit.benefitDescription,
                  style: AppTextStyles.bodyMedium),
              const SizedBox(height: 6),
              Text(rateLabel, style: AppTextStyles.benefitRate),
              if (benefit.conditions.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(benefit.conditions,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textSecondary)),
              ],
              if (matchedBenefit.isMerchantSpecific) ...[
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withAlpha(30),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '가맹점 특화 혜택',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'cashback':
        return '캐시백';
      case 'point':
        return '적립';
      default:
        return '할인';
    }
  }

  String _formatKrw(int amount) {
    final str = amount.toString();
    final buf = StringBuffer();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buf.write(',');
      buf.write(str[i]);
    }
    return '$buf원';
  }
}
