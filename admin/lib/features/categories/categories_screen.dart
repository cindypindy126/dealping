import 'package:flutter/material.dart';
import '../../core/theme/admin_theme.dart';
import '../../shared/widgets/admin_scaffold.dart';

class CategoryItem {
  final String id;
  String name;
  String iconCode;
  bool isActive;

  CategoryItem({
    required this.id,
    required this.name,
    required this.iconCode,
    required this.isActive,
  });
}

final List<CategoryItem> mockCategories = [
  CategoryItem(id: 'food', name: '식사/카페', iconCode: 'e56c', isActive: true),
  CategoryItem(id: 'gas', name: '주유', iconCode: 'e549', isActive: true),
  CategoryItem(
    id: 'transport',
    name: '교통',
    iconCode: 'e531',
    isActive: true,
  ),
  CategoryItem(id: 'shopping', name: '쇼핑', iconCode: 'e59c', isActive: true),
  CategoryItem(
    id: 'medical',
    name: '의료/약국',
    iconCode: 'e548',
    isActive: true,
  ),
  CategoryItem(
    id: 'communication',
    name: '통신',
    iconCode: 'e0cd',
    isActive: true,
  ),
  CategoryItem(
    id: 'insurance',
    name: '보험',
    iconCode: 'e1af',
    isActive: false,
  ),
  CategoryItem(id: 'education', name: '교육', iconCode: 'e80c', isActive: true),
];

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool _showAddForm = false;
  final _nameController = TextEditingController();
  final _iconController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  void _handleAdd() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('카테고리명을 입력해주세요.'),
          backgroundColor: AdminTheme.error,
        ),
      );
      return;
    }

    try {
      setState(() {
        mockCategories.add(
          CategoryItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: _nameController.text.trim(),
            iconCode: _iconController.text.trim().isEmpty
                ? 'e88a'
                : _iconController.text.trim(),
            isActive: true,
          ),
        );
        _nameController.clear();
        _iconController.clear();
        _showAddForm = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('카테고리가 추가되었습니다.'),
          backgroundColor: AdminTheme.success,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('카테고리 추가 중 오류가 발생했습니다: $e'),
          backgroundColor: AdminTheme.error,
        ),
      );
    }
  }

  void _showEditDialog(CategoryItem item) {
    final nameCtrl = TextEditingController(text: item.name);
    final iconCtrl = TextEditingController(text: item.iconCode);

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('카테고리 수정'),
        content: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: '카테고리명 *'),
                autofocus: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: iconCtrl,
                decoration: const InputDecoration(
                  labelText: '아이콘코드 (hex)',
                  hintText: 'e56c',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AdminTheme.primary,
            ),
            onPressed: () {
              if (nameCtrl.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('카테고리명을 입력해주세요.'),
                    backgroundColor: AdminTheme.error,
                  ),
                );
                return;
              }
              try {
                setState(() {
                  item.name = nameCtrl.text.trim();
                  item.iconCode = iconCtrl.text.trim().isEmpty
                      ? item.iconCode
                      : iconCtrl.text.trim();
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('카테고리가 수정되었습니다.'),
                    backgroundColor: AdminTheme.success,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('카테고리 수정 중 오류가 발생했습니다: $e'),
                    backgroundColor: AdminTheme.error,
                  ),
                );
              }
            },
            child: const Text('저장'),
          ),
        ],
      ),
    ).then((_) {
      nameCtrl.dispose();
      iconCtrl.dispose();
    });
  }

  Future<void> _confirmDelete(CategoryItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text('"${item.name}" 카테고리를 삭제하시겠습니까?'),
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
      setState(() => mockCategories.removeWhere((c) => c.id == item.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '카테고리 관리',
      selectedIndex: 2,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Text(
                  '카테고리 목록',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AdminTheme.textPrimary,
                  ),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () =>
                      setState(() => _showAddForm = !_showAddForm),
                  icon: Icon(_showAddForm ? Icons.close : Icons.add),
                  label: Text(_showAddForm ? '닫기' : '추가'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AdminTheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Add form (inline)
            if (_showAddForm) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: '카테고리명 *',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _iconController,
                          decoration: const InputDecoration(
                            labelText: '아이콘코드 (hex)',
                            hintText: 'e56c',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: _handleAdd,
                        style: FilledButton.styleFrom(
                          backgroundColor: AdminTheme.success,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                        ),
                        child: const Text('저장'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            const Text(
              '드래그하여 순서를 변경할 수 있습니다.',
              style: TextStyle(
                fontSize: 12,
                color: AdminTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),

            // Reorderable list
            Expanded(
              child: Card(
                child: ReorderableListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: mockCategories.length,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex--;
                      final item = mockCategories.removeAt(oldIndex);
                      mockCategories.insert(newIndex, item);
                    });
                  },
                  itemBuilder: (context, index) {
                    final cat = mockCategories[index];
                    return ListTile(
                      key: ValueKey(cat.id),
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.drag_indicator,
                            color: AdminTheme.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 36,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AdminTheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              cat.iconCode,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AdminTheme.primary,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        cat.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '순서: ${index + 1}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AdminTheme.textSecondary,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: cat.isActive,
                            onChanged: (v) =>
                                setState(() => cat.isActive = v),
                            activeThumbColor: AdminTheme.success,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: AdminTheme.primary,
                              size: 20,
                            ),
                            tooltip: '수정',
                            onPressed: () => _showEditDialog(cat),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: AdminTheme.error,
                              size: 20,
                            ),
                            onPressed: () => _confirmDelete(cat),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
