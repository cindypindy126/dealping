import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/models.dart';
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
  bool _searchFocused = false;
  final _searchFocus = FocusNode();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedMerchant = widget.initialMerchant;
    _searchFocus.addListener(() {
      setState(() => _searchFocused = _searchFocus.hasFocus);
    });
    Future.microtask(() =>
        ref.read(searchCountProvider.notifier).load());
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Merchant> _sortedMerchants(List<Merchant> all) {
    final counts = ref.read(searchCountProvider);

    List<Merchant> filtered;
    if (_merchantQuery.isEmpty) {
      filtered = all;
    } else {
      final lower = _merchantQuery.toLowerCase();
      filtered = all
          .where((m) =>
              m.name.toLowerCase().contains(lower) ||
              m.aliases.any((a) => a.toLowerCase().contains(lower)))
          .toList();
    }

    filtered.sort((a, b) {
      final countDiff = (counts[b.id] ?? 0).compareTo(counts[a.id] ?? 0);
      if (countDiff != 0) return countDiff;
      return a.name.compareTo(b.name);
    });
    return filtered;
  }

  void _selectMerchant(Merchant m) {
    ref.read(searchCountProvider.notifier).increment(m.id);
    setState(() {
      _selectedMerchant = _selectedMerchant?.id == m.id ? null : m;
      _merchantQuery = '';
      _searchController.clear();
    });
    _searchFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final categoryName = categoriesAsync.when(
      data: (cats) => cats.firstWhere((c) => c.id == widget.categoryId,
          orElse: () => cats.first).name,
      loading: () => '카테고리',
      error: (_, __) => '카테고리',
    );

    final merchantsAsync = ref.watch(merchantsByCategoryProvider(widget.categoryId));
    final merchants = merchantsAsync.when(
      data: (m) => m,
      loading: () => <Merchant>[],
      error: (_, __) => <Merchant>[],
    );
    final sortedMerchants = _sortedMerchants(merchants);

    final myProviderIds = ref.watch(myProvidersProvider);
    final benefitsAsync = ref.watch(matchedBenefitsProvider((
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
        title: Text(categoryName, style: AppTextStyles.titleMedium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Merchant search
            TextField(
              controller: _searchController,
              focusNode: _searchFocus,
              decoration: InputDecoration(
                hintText: '가맹점 검색',
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.textSecondary),
                suffixIcon: _merchantQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear,
                            color: AppColors.textSecondary),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _merchantQuery = '');
                        },
                      )
                    : null,
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

            // Merchant list (포커스 중이거나 검색어 있을 때)
            if (_searchFocused || _merchantQuery.isNotEmpty) ...[
              const SizedBox(height: 4),
              Container(
                constraints: const BoxConstraints(maxHeight: 240),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: sortedMerchants.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('검색 결과 없음',
                            style: AppTextStyles.bodySmall
                                .copyWith(color: AppColors.textSecondary)),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: sortedMerchants.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, indent: 16, endIndent: 16),
                        itemBuilder: (_, i) {
                          final m = sortedMerchants[i];
                          final selected = _selectedMerchant?.id == m.id;
                          return ListTile(
                            dense: true,
                            leading: Icon(
                              Icons.store_outlined,
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              size: 20,
                            ),
                            title: Text(m.name,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: selected
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                  fontWeight: selected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                )),
                            trailing: selected
                                ? const Icon(Icons.check,
                                    color: AppColors.primary, size: 18)
                                : null,
                            onTap: () => _selectMerchant(m),
                          );
                        },
                      ),
              ),
            ],

            // Selected merchant chip
            if (_selectedMerchant != null && !_searchFocused) ...[
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
            else
              benefitsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const EmptyState(
                  icon: Icons.error_outline,
                  title: '혜택을 불러오지 못했습니다',
                  subtitle: '잠시 후 다시 시도해주세요',
                ),
                data: (benefits) => benefits.isEmpty
                    ? const EmptyState(
                        icon: Icons.search_off,
                        title: '등록된 카드 중 해당 혜택이 없습니다',
                        subtitle: '다른 카테고리나 카드를 확인해보세요',
                      )
                    : Column(
                        children: benefits
                            .map((mb) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: BenefitCard(
                                    matchedBenefit: mb,
                                    onTap: () => context
                                        .push('/provider/${mb.provider.id}'),
                                  ),
                                ))
                            .toList(),
                      ),
              ),

            const SizedBox(height: 16),
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
