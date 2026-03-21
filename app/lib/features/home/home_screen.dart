import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/models.dart';
import '../../data/services/mock_data_service.dart';
import '../../shared/widgets/provider_type_badge.dart';
import '../providers/app_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(mockCategoriesProvider);
    final myProviderIds = ref.watch(myProvidersProvider);
    final hasCards = myProviderIds.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'DealPing',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // No cards banner
            if (!hasCards) ...[
              _NoCardsBanner(onTap: () => context.go('/my-cards')),
              const SizedBox(height: 20),
            ],

            // Search bar
            GestureDetector(
              onTap: () => context.push('/search'),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.textSecondary),
                    const SizedBox(width: 12),
                    Text(
                      '어디서 결제하세요?',
                      style: AppTextStyles.bodyLarge
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Category section
            Text('카테고리',
                style: AppTextStyles.titleMedium
                    .copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                return _CategoryGridItem(
                  category: cat,
                  onTap: () => context.push('/category/${cat.id}'),
                );
              },
            ),

            const SizedBox(height: 28),

            // My providers preview (if any)
            if (hasCards) ...[
              Text('내 카드',
                  style: AppTextStyles.titleMedium
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              _MyProvidersPreview(providerIds: myProviderIds),
            ],
          ],
        ),
      ),
    );
  }
}

class _NoCardsBanner extends StatelessWidget {
  final VoidCallback onTap;
  const _NoCardsBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha(15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withAlpha(60)),
        ),
        child: Row(
          children: [
            const Icon(Icons.credit_card_outlined,
                color: AppColors.primary, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('카드를 등록하고 혜택을 확인하세요',
                      style: AppTextStyles.titleMedium
                          .copyWith(color: AppColors.primary)),
                  const SizedBox(height: 4),
                  Text('+ 카드 추가하기',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.primary)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

class _CategoryGridItem extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const _CategoryGridItem({required this.category, required this.onTap});

  IconData _iconForCategory(String icon) {
    switch (icon) {
      case 'coffee':
        return Icons.coffee;
      case 'store':
        return Icons.store;
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'delivery_dining':
        return Icons.delivery_dining;
      case 'local_gas_station':
        return Icons.local_gas_station;
      case 'apps':
        return Icons.apps;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withValues(alpha: 0.10),
            offset: const Offset(0, 3),
            blurRadius: 7,
            spreadRadius: 1,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _iconForCategory(category.icon),
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: AppTextStyles.labelMedium
                  .copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _MyProvidersPreview extends StatelessWidget {
  final List<String> providerIds;
  const _MyProvidersPreview({required this.providerIds});

  @override
  Widget build(BuildContext context) {
    final all = providerIds
        .map(MockDataService.getProvider)
        .whereType<BenefitProvider>()
        .toList();
    final providers = [
      ...all.where((p) => p.cardType == 'credit'),
      ...all.where((p) => p.cardType == 'debit'),
      ...all.where((p) => p.providerType == 'telecom'),
    ];

    return Column(
      children: [
        for (final provider in providers) ...[
          GestureDetector(
            onTap: () => context.push('/provider/${provider.id}'),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.10),
                    offset: const Offset(0, 3),
                    blurRadius: 7,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      provider.providerType == 'telecom'
                          ? Icons.phone_android
                          : Icons.credit_card,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${provider.issuerName} ${provider.name}',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                  ProviderTypeBadge(
                    providerType: provider.providerType,
                    cardType: provider.cardType,
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right,
                      color: AppColors.textSecondary, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
