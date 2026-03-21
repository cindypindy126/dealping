import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/admin_theme.dart';
import '../../shared/widgets/admin_scaffold.dart';

class ProviderItem {
  final String id;
  final String name;
  final String providerType; // card | telecom
  final String? cardType; // credit | debit | null
  final String issuerCode;
  final String issuerName;
  final int annualFee;
  bool isActive;

  ProviderItem({
    required this.id,
    required this.name,
    required this.providerType,
    this.cardType,
    required this.issuerCode,
    required this.issuerName,
    required this.annualFee,
    required this.isActive,
  });
}

// Shared mock data store
final List<ProviderItem> mockProviders = [
  ProviderItem(
    id: '1',
    name: '신한카드 My Car',
    providerType: 'card',
    cardType: 'credit',
    issuerCode: 'SHINHAN',
    issuerName: '신한카드',
    annualFee: 15000,
    isActive: true,
  ),
  ProviderItem(
    id: '2',
    name: 'KB국민 티타늄',
    providerType: 'card',
    cardType: 'credit',
    issuerCode: 'KB',
    issuerName: 'KB국민카드',
    annualFee: 30000,
    isActive: true,
  ),
  ProviderItem(
    id: '3',
    name: 'SKT 0플랜',
    providerType: 'telecom',
    cardType: null,
    issuerCode: 'SKT',
    issuerName: 'SKT',
    annualFee: 0,
    isActive: true,
  ),
];

class ProvidersScreen extends StatefulWidget {
  const ProvidersScreen({super.key});

  @override
  State<ProvidersScreen> createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  String _searchQuery = '';

  List<ProviderItem> get _filtered => mockProviders
      .where(
        (p) =>
            _searchQuery.isEmpty ||
            p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.issuerName.toLowerCase().contains(_searchQuery.toLowerCase()),
      )
      .toList();

  Future<void> _confirmDelete(ProviderItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text('"${item.name}"을(를) 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: AdminTheme.error,
            ),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => mockProviders.removeWhere((p) => p.id == item.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${item.name}" 삭제되었습니다.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '카드/통신사 관리',
      selectedIndex: 1,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: '이름 또는 발급사로 검색...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (v) => setState(() => _searchQuery = v),
                  ),
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: () => context.go('/providers/new'),
                  icon: const Icon(Icons.add),
                  label: const Text('추가'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AdminTheme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Data table
            Expanded(
              child: _filtered.isEmpty
                  ? const Center(
                      child: Text(
                        '검색 결과가 없습니다.',
                        style: TextStyle(color: AdminTheme.textSecondary),
                      ),
                    )
                  : Card(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            headingRowColor: WidgetStateProperty.all(
                              AdminTheme.background,
                            ),
                            columns: const [
                              DataColumn(label: Text('이름')),
                              DataColumn(label: Text('제공자 유형')),
                              DataColumn(label: Text('카드 유형')),
                              DataColumn(label: Text('발급사')),
                              DataColumn(label: Text('연회비')),
                              DataColumn(label: Text('활성화')),
                              DataColumn(label: Text('액션')),
                            ],
                            rows: _filtered.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    _TypeChip(
                                      label: item.providerType == 'card'
                                          ? '카드'
                                          : '통신사',
                                      color: item.providerType == 'card'
                                          ? AdminTheme.primary
                                          : AdminTheme.secondary,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.cardType == null
                                          ? '-'
                                          : item.cardType == 'credit'
                                              ? '신용'
                                              : '체크',
                                    ),
                                  ),
                                  DataCell(Text(item.issuerName)),
                                  DataCell(
                                    Text(
                                      item.annualFee == 0
                                          ? '없음'
                                          : '${item.annualFee.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}원',
                                    ),
                                  ),
                                  DataCell(
                                    Switch(
                                      value: item.isActive,
                                      onChanged: (v) {
                                        setState(() => item.isActive = v);
                                      },
                                      activeThumbColor: AdminTheme.success,
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.star_outline,
                                            size: 18,
                                          ),
                                          tooltip: '혜택 관리',
                                          onPressed: () => context.go(
                                            '/providers/${item.id}/benefits?name=${Uri.encodeComponent(item.name)}',
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit_outlined,
                                            size: 18,
                                          ),
                                          tooltip: '편집',
                                          onPressed: () => context.go(
                                            '/providers/${item.id}',
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            size: 18,
                                            color: AdminTheme.error,
                                          ),
                                          tooltip: '삭제',
                                          onPressed: () =>
                                              _confirmDelete(item),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final Color color;

  const _TypeChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
