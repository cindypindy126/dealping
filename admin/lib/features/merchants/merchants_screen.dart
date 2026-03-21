import 'package:flutter/material.dart';
import '../../core/theme/admin_theme.dart';
import '../../shared/widgets/admin_scaffold.dart';

class MerchantItem {
  final String id;
  String name;
  String categoryId;
  String categoryName;
  List<String> aliases;
  bool isFranchise;
  bool isActive;

  MerchantItem({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.aliases,
    required this.isFranchise,
    required this.isActive,
  });
}

final List<MerchantItem> mockMerchants = [
  MerchantItem(
    id: 'm1',
    name: 'GS칼텍스',
    categoryId: 'gas',
    categoryName: '주유',
    aliases: ['GS주유소', 'GS칼텍스주유소'],
    isFranchise: true,
    isActive: true,
  ),
  MerchantItem(
    id: 'm2',
    name: '스타벅스',
    categoryId: 'food',
    categoryName: '식사/카페',
    aliases: ['스벅', 'Starbucks'],
    isFranchise: true,
    isActive: true,
  ),
  MerchantItem(
    id: 'm3',
    name: '이마트',
    categoryId: 'shopping',
    categoryName: '쇼핑',
    aliases: ['E-mart', '이마트트레이더스'],
    isFranchise: true,
    isActive: true,
  ),
  MerchantItem(
    id: 'm4',
    name: '올리브영',
    categoryId: 'shopping',
    categoryName: '쇼핑',
    aliases: ['CJ올리브영', 'OLIVE YOUNG'],
    isFranchise: true,
    isActive: true,
  ),
];

const _categoryOptions = [
  ('', '전체'),
  ('food', '식사/카페'),
  ('gas', '주유'),
  ('transport', '교통'),
  ('shopping', '쇼핑'),
  ('medical', '의료/약국'),
  ('communication', '통신'),
  ('insurance', '보험'),
  ('education', '교육'),
];

class MerchantsScreen extends StatefulWidget {
  const MerchantsScreen({super.key});

  @override
  State<MerchantsScreen> createState() => _MerchantsScreenState();
}

class _MerchantsScreenState extends State<MerchantsScreen> {
  String _filterCategory = '';

  List<MerchantItem> get _filtered => mockMerchants
      .where(
        (m) => _filterCategory.isEmpty || m.categoryId == _filterCategory,
      )
      .toList();

  void _showAddDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => _MerchantFormDialog(
        onSave: (merchant) {
          setState(() => mockMerchants.add(merchant));
        },
      ),
    );
  }

  void _showEditDialog(MerchantItem item) {
    showDialog<void>(
      context: context,
      builder: (ctx) => _MerchantFormDialog(
        existing: item,
        onSave: (updated) {
          setState(() {
            final index = mockMerchants.indexWhere((m) => m.id == item.id);
            if (index != -1) {
              mockMerchants[index] = updated;
            }
          });
        },
      ),
    );
  }

  Future<void> _confirmDelete(MerchantItem item) async {
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
            style: FilledButton.styleFrom(backgroundColor: AdminTheme.error),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => mockMerchants.removeWhere((m) => m.id == item.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '가맹점 관리',
      selectedIndex: 3,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Controls
            Row(
              children: [
                DropdownButton<String>(
                  value: _filterCategory,
                  hint: const Text('카테고리 필터'),
                  items: _categoryOptions
                      .map(
                        (c) => DropdownMenuItem(
                          value: c.$1,
                          child: Text(c.$2),
                        ),
                      )
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _filterCategory = v ?? ''),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: _showAddDialog,
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
            const SizedBox(height: 16),

            // Table
            Expanded(
              child: _filtered.isEmpty
                  ? const Center(
                      child: Text(
                        '가맹점이 없습니다.',
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
                              DataColumn(label: Text('카테고리')),
                              DataColumn(label: Text('별칭')),
                              DataColumn(label: Text('프랜차이즈')),
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
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AdminTheme.primary
                                            .withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        item.categoryName,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AdminTheme.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      item.aliases.join(', '),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  DataCell(
                                    item.isFranchise
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: AdminTheme.success,
                                            size: 18,
                                          )
                                        : const Icon(
                                            Icons.remove,
                                            color: AdminTheme.textSecondary,
                                            size: 18,
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
                                            Icons.edit_outlined,
                                            size: 18,
                                          ),
                                          tooltip: '편집',
                                          onPressed: () =>
                                              _showEditDialog(item),
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

class _MerchantFormDialog extends StatefulWidget {
  final MerchantItem? existing;
  final void Function(MerchantItem) onSave;

  const _MerchantFormDialog({this.existing, required this.onSave});

  @override
  State<_MerchantFormDialog> createState() => _MerchantFormDialogState();
}

class _MerchantFormDialogState extends State<_MerchantFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _aliasesController;
  String _categoryId = _categoryOptions[1].$1;
  String _categoryName = _categoryOptions[1].$2;
  bool _isFranchise = false;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final ex = widget.existing;
    _nameController = TextEditingController(text: ex?.name ?? '');
    _aliasesController =
        TextEditingController(text: ex?.aliases.join(', ') ?? '');
    if (ex != null) {
      _categoryId = ex.categoryId;
      _categoryName = ex.categoryName;
      _isFranchise = ex.isFranchise;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aliasesController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final aliases = _aliasesController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final merchant = MerchantItem(
      id: widget.existing?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      categoryId: _categoryId,
      categoryName: _categoryName,
      aliases: aliases,
      isFranchise: _isFranchise,
      isActive: widget.existing?.isActive ?? true,
    );

    widget.onSave(merchant);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEdit ? '가맹점 편집' : '가맹점 추가'),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 가맹점명
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: '가맹점명 *'),
                validator: (v) =>
                    v == null || v.isEmpty ? '가맹점명을 입력해주세요.' : null,
              ),
              const SizedBox(height: 12),

              // 카테고리
              DropdownButtonFormField<String>(
                // ignore: deprecated_member_use
                value: _categoryId,
                decoration: const InputDecoration(labelText: '카테고리'),
                items: _categoryOptions
                    .where((c) => c.$1.isNotEmpty)
                    .map(
                      (c) => DropdownMenuItem(
                        value: c.$1,
                        child: Text(c.$2),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    _categoryId = v!;
                    _categoryName = _categoryOptions
                        .firstWhere((c) => c.$1 == v)
                        .$2;
                  });
                },
              ),
              const SizedBox(height: 12),

              // 별칭
              TextFormField(
                controller: _aliasesController,
                decoration: const InputDecoration(
                  labelText: '별칭 (쉼표로 구분)',
                  hintText: '스벅, Starbucks',
                ),
              ),
              const SizedBox(height: 12),

              // 프랜차이즈
              CheckboxListTile(
                title: const Text('프랜차이즈'),
                value: _isFranchise,
                onChanged: (v) => setState(() => _isFranchise = v ?? false),
                contentPadding: EdgeInsets.zero,
                activeColor: AdminTheme.primary,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        FilledButton(
          onPressed: _handleSave,
          style: FilledButton.styleFrom(backgroundColor: AdminTheme.primary),
          child: Text(_isEdit ? '수정' : '추가'),
        ),
      ],
    );
  }
}
