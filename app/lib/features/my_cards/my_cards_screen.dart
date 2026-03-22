import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/models.dart';
import '../../features/providers/app_providers.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/provider_type_badge.dart';

class MyCardsScreen extends ConsumerStatefulWidget {
  const MyCardsScreen({super.key});

  @override
  ConsumerState<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends ConsumerState<MyCardsScreen> {
  bool _deleteMode = false;
  final Set<String> _selectedIds = {};

  void _enterDeleteMode() => setState(() {
        _deleteMode = true;
        _selectedIds.clear();
      });

  void _exitDeleteMode() => setState(() {
        _deleteMode = false;
        _selectedIds.clear();
      });

  void _toggleSelect(String id) => setState(() {
        if (_selectedIds.contains(id)) {
          _selectedIds.remove(id);
        } else {
          _selectedIds.add(id);
        }
      });

  Future<void> _deleteSelected() async {
    if (_selectedIds.isEmpty) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('카드 삭제'),
        content: Text('선택한 ${_selectedIds.length}개 항목을 삭제할까요?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('삭제',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      for (final id in _selectedIds) {
        await ref.read(myProvidersProvider.notifier).remove(id);
      }
      _exitDeleteMode();
    }
  }

  Future<void> _showAddProviderSheet(List<String> currentIds) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _AddProviderSheet(currentIds: currentIds),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myProviderIds = ref.watch(myProvidersProvider);
    final allAsync = ref.watch(allProvidersProvider);
    final myProviders = allAsync.when(
      data: (all) => all.where((p) => myProviderIds.contains(p.id)).toList(),
      loading: () => <BenefitProvider>[],
      error: (_, __) => <BenefitProvider>[],
    );

    final credit = myProviders.where((p) => p.cardType == 'credit').toList();
    final debit = myProviders.where((p) => p.cardType == 'debit').toList();
    final telecom =
        myProviders.where((p) => p.providerType == 'telecom').toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('내 카드 & 통신사',
            style: AppTextStyles.titleMedium
                .copyWith(fontWeight: FontWeight.w700)),
        actions: _deleteMode
            ? [
                if (_selectedIds.isNotEmpty)
                  TextButton(
                    onPressed: _deleteSelected,
                    child: Text(
                      '${_selectedIds.length}개 삭제',
                      style: const TextStyle(
                          color: AppColors.error, fontWeight: FontWeight.w700),
                    ),
                  ),
                TextButton(
                  onPressed: _exitDeleteMode,
                  child: const Text('취소',
                      style: TextStyle(color: AppColors.textSecondary)),
                ),
              ]
            : [
                if (myProviders.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline,
                        color: AppColors.error),
                    tooltip: '카드/통신사 삭제',
                    onPressed: _enterDeleteMode,
                  ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
                  tooltip: '카드/통신사 추가',
                  onPressed: () => _showAddProviderSheet(myProviderIds),
                ),
              ],
      ),
      floatingActionButton: (!_deleteMode && myProviders.isNotEmpty)
          ? FloatingActionButton.extended(
              onPressed: () => _showAddProviderSheet(myProviderIds),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('카드/통신사 추가'),
            )
          : null,
      body: myProviders.isEmpty
          ? EmptyState(
              icon: Icons.credit_card_outlined,
              title: '아직 등록된 카드가 없어요',
              subtitle: '카드나 통신사를 추가하면\n내 혜택을 바로 확인할 수 있어요',
              actionLabel: '카드 추가하기',
              onAction: () => _showAddProviderSheet(myProviderIds),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (credit.isNotEmpty) ...[
                  _SectionHeader(title: '신용카드', count: credit.length),
                  const SizedBox(height: 8),
                  ...credit.map((p) => _ProviderListItem(
                        provider: p,
                        deleteMode: _deleteMode,
                        selected: _selectedIds.contains(p.id),
                        onToggleSelect: () => _toggleSelect(p.id),
                        onDelete: () =>
                            ref.read(myProvidersProvider.notifier).remove(p.id),
                      )),
                  const SizedBox(height: 20),
                ],
                if (debit.isNotEmpty) ...[
                  _SectionHeader(title: '체크카드', count: debit.length),
                  const SizedBox(height: 8),
                  ...debit.map((p) => _ProviderListItem(
                        provider: p,
                        deleteMode: _deleteMode,
                        selected: _selectedIds.contains(p.id),
                        onToggleSelect: () => _toggleSelect(p.id),
                        onDelete: () =>
                            ref.read(myProvidersProvider.notifier).remove(p.id),
                      )),
                  const SizedBox(height: 20),
                ],
                if (telecom.isNotEmpty) ...[
                  _SectionHeader(title: '통신사', count: telecom.length),
                  const SizedBox(height: 8),
                  ...telecom.map((p) => _ProviderListItem(
                        provider: p,
                        deleteMode: _deleteMode,
                        selected: _selectedIds.contains(p.id),
                        onToggleSelect: () => _toggleSelect(p.id),
                        onDelete: () =>
                            ref.read(myProvidersProvider.notifier).remove(p.id),
                      )),
                ],
                const SizedBox(height: 100),
              ],
            ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textSecondary, fontWeight: FontWeight.w600);
    return Row(
      children: [
        Text(title, style: style),
        const SizedBox(width: 6),
        Text('$count', style: style),
      ],
    );
  }
}

class _ProviderListItem extends StatelessWidget {
  final BenefitProvider provider;
  final bool deleteMode;
  final bool selected;
  final VoidCallback onToggleSelect;
  final VoidCallback onDelete;

  const _ProviderListItem({
    required this.provider,
    required this.deleteMode,
    required this.selected,
    required this.onToggleSelect,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.error.withAlpha(15)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? AppColors.error.withAlpha(120) : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          if (deleteMode)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Checkbox(
                value: selected,
                activeColor: AppColors.error,
                onChanged: (_) => onToggleSelect(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      provider.providerType == 'telecom'
                          ? Icons.phone_android
                          : Icons.credit_card,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(provider.issuerName,
                            style: AppTextStyles.bodySmall),
                        Text(provider.name,
                            style: AppTextStyles.titleMedium),
                      ],
                    ),
                  ),
                  ProviderTypeBadge(
                    providerType: provider.providerType,
                    cardType: provider.cardType,
                  ),
                  if (!deleteMode)
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.chevron_right,
                          color: AppColors.textSecondary, size: 20),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (deleteMode) {
      return GestureDetector(
        onTap: onToggleSelect,
        child: card,
      );
    }

    return Dismissible(
      key: ValueKey(provider.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.error.withAlpha(200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('카드 삭제'),
            content: Text(
                '${provider.issuerName} ${provider.name}을(를) 삭제할까요?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('취소')),
              TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('삭제',
                      style: TextStyle(color: AppColors.error))),
            ],
          ),
        );
      },
      onDismissed: (_) => onDelete(),
      child: GestureDetector(
        onTap: () => context.push('/provider/${provider.id}'),
        child: card,
      ),
    );
  }
}

class _AddProviderSheet extends ConsumerStatefulWidget {
  final List<String> currentIds;
  const _AddProviderSheet({required this.currentIds});

  @override
  ConsumerState<_AddProviderSheet> createState() => _AddProviderSheetState();
}

class _AddProviderSheetState extends ConsumerState<_AddProviderSheet> {
  String _query = '';

  List<BenefitProvider> _filtered(List<BenefitProvider> all) {
    if (_query.isEmpty) return all;
    final lower = _query.toLowerCase();
    return all
        .where((p) =>
            p.name.toLowerCase().contains(lower) ||
            p.issuerName.toLowerCase().contains(lower))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final allAsync = ref.watch(allProvidersProvider);
    final filtered = allAsync.when(
      data: (all) => _filtered(all),
      loading: () => <BenefitProvider>[],
      error: (_, __) => <BenefitProvider>[],
    );

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      builder: (ctx, scrollController) => Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('카드/통신사 추가',
                style: AppTextStyles.titleMedium
                    .copyWith(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: '카드사 또는 통신사 검색',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filtered.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, indent: 0),
              itemBuilder: (_, i) {
                final p = filtered[i];
                final alreadyAdded = widget.currentIds.contains(p.id);
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: alreadyAdded
                          ? AppColors.success.withAlpha(30)
                          : AppColors.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      alreadyAdded ? Icons.check : Icons.credit_card,
                      color: alreadyAdded
                          ? AppColors.success
                          : AppColors.primary,
                      size: 20,
                    ),
                  ),
                  title: Text('${p.issuerName} ${p.name}',
                      style: AppTextStyles.bodyMedium),
                  trailing: ProviderTypeBadge(
                    providerType: p.providerType,
                    cardType: p.cardType,
                  ),
                  onTap: alreadyAdded
                      ? null
                      : () async {
                          await ref
                              .read(myProvidersProvider.notifier)
                              .add(p.id);
                          if (context.mounted) Navigator.pop(context);
                        },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
