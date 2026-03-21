import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/models.dart';
import '../../data/services/mock_data_service.dart';
import '../../features/providers/app_providers.dart';
import '../../shared/widgets/benefit_card.dart';
import '../../shared/widgets/empty_state.dart';

class CategoryDetailScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final Merchant? initialMerchant;

  const CategoryDetailScreen({
    super.key,
    required this.categoryId,
    this.initialMerchant,
  });

  @override
  ConsumerState<CategoryDetailScreen> createState() =>
      _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends ConsumerState<CategoryDetailScreen> {
  Merchant? _selectedMerchant;
  String _merchantQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedMerchant = widget.initialMerchant;
  }

  List<Merchant> get _filteredMerchants {
    final all =
        MockDataService.getMerchantsForCategory(widget.categoryId);
    if (_merchantQuery.isEmpty) return all;
    final lower = _merchantQuery.toLowerCase();
    return all
        .where((m) =>
            m.name.toLowerCase().contains(lower) ||
            m.aliases.any((a) => a.toLowerCase().contains(lower)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final category = MockDataService.getCategory(widget.categoryId);
    final myProviderIds = ref.watch(myProvidersProvider);
    final benefits = ref.watch(matchedBenefitsProvider((
      categoryId: widget.categoryId,
      merchantId: _selectedMerchant?.id,
    )));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(category?.name ?? '카테고리',
            style: AppTextStyles.titleMedium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Merchant search
            TextField(
              decoration: InputDecoration(
                hintText: '가맹점 검색',
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (v) => setState(() => _merchantQuery = v),
            ),

            // Merchant chips
            if (_merchantQuery.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _filteredMerchants.map((m) {
                  final selected = _selectedMerchant?.id == m.id;
                  return ChoiceChip(
                    label: Text(m.name),
                    selected: selected,
                    selectedColor: AppColors.primary.withAlpha(40),
                    onSelected: (_) {
                      setState(() {
                        _selectedMerchant = selected ? null : m;
                        _merchantQuery = '';
                      });
                    },
                  );
                }).toList(),
              ),
            ],

            // Selected merchant chip
            if (_selectedMerchant != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Chip(
                    label: Text('가맹점: ${_selectedMerchant!.name}',
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.primary)),
                    backgroundColor: AppColors.primary.withAlpha(20),
                    deleteIcon: const Icon(Icons.close,
                        size: 16, color: AppColors.primary),
                    onDeleted: () =>
                        setState(() => _selectedMerchant = null),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 20),
            Text('내 혜택 카드',
                style: AppTextStyles.titleMedium
                    .copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),

            if (myProviderIds.isEmpty)
              EmptyState(
                icon: Icons.credit_card_outlined,
                title: '등록된 카드가 없어요',
                subtitle: '카드를 등록하고 혜택을 확인해보세요',
                actionLabel: '카드 추가하기',
                onAction: () => context.go('/my-cards'),
              )
            else if (benefits.isEmpty)
              const EmptyState(
                icon: Icons.search_off,
                title: '등록된 카드 중 해당 혜택이 없습니다',
                subtitle: '다른 카테고리나 카드를 확인해보세요',
              )
            else
              ...benefits.map((mb) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: BenefitCard(
                      matchedBenefit: mb,
                      onTap: () =>
                          context.push('/provider/${mb.provider.id}'),
                    ),
                  )),

            const SizedBox(height: 16),
            // Disclaimer
            Text(
              '* 전월실적 및 합산 할인액은 카드 개별 정보를 참고하세요',
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
