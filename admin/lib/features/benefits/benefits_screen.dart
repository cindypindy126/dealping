import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/admin_theme.dart';

// Benefit types
enum BenefitType { discount, cashback, point }

enum BenefitValueType { percent, fixed }

class BenefitItem {
  final String id;
  final String categoryId;
  final String categoryName;
  final String? merchantId;
  final String? merchantName;
  final BenefitType benefitType;
  final BenefitValueType valueType;
  final double value;
  final String description;
  final String condition;
  bool isActive;

  BenefitItem({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    this.merchantId,
    this.merchantName,
    required this.benefitType,
    required this.valueType,
    required this.value,
    required this.description,
    required this.condition,
    required this.isActive,
  });
}

// Mock benefits per provider
final Map<String, List<BenefitItem>> mockBenefits = {
  '1': [
    BenefitItem(
      id: 'b1',
      categoryId: 'food',
      categoryName: '식사/카페',
      merchantId: null,
      merchantName: null,
      benefitType: BenefitType.cashback,
      valueType: BenefitValueType.percent,
      value: 5,
      description: '식사 업종 전반 5% 캐시백',
      condition: '월 10만원 이상 사용 시',
      isActive: true,
    ),
    BenefitItem(
      id: 'b2',
      categoryId: 'gas',
      categoryName: '주유',
      merchantId: 'm1',
      merchantName: 'GS칼텍스',
      benefitType: BenefitType.discount,
      valueType: BenefitValueType.fixed,
      value: 60,
      description: 'GS칼텍스 리터당 60원 할인',
      condition: '전월 30만원 이상 사용',
      isActive: true,
    ),
  ],
};

const _mockCategories = [
  ('food', '식사/카페'),
  ('gas', '주유'),
  ('transport', '교통'),
  ('shopping', '쇼핑'),
  ('medical', '의료/약국'),
  ('communication', '통신'),
  ('insurance', '보험'),
  ('education', '교육'),
];

const _mockMerchants = [
  ('m1', 'GS칼텍스'),
  ('m2', '스타벅스'),
  ('m3', '이마트'),
  ('m4', '올리브영'),
];

class BenefitsScreen extends StatefulWidget {
  final String providerId;
  final String providerName;

  const BenefitsScreen({
    super.key,
    required this.providerId,
    required this.providerName,
  });

  @override
  State<BenefitsScreen> createState() => _BenefitsScreenState();
}

class _BenefitsScreenState extends State<BenefitsScreen> {
  List<BenefitItem> get _benefits =>
      mockBenefits[widget.providerId] ?? [];

  void _showAddDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => _BenefitFormDialog(
        onSave: (benefit) {
          setState(() {
            final list = mockBenefits.putIfAbsent(widget.providerId, () => []);
            list.add(benefit);
          });
        },
      ),
    );
  }

  void _showEditDialog(BenefitItem item) {
    showDialog<void>(
      context: context,
      builder: (ctx) => _BenefitFormDialog(
        existing: item,
        onSave: (updated) {
          setState(() {
            final list = mockBenefits[widget.providerId];
            if (list != null) {
              final idx = list.indexWhere((b) => b.id == updated.id);
              if (idx != -1) list[idx] = updated;
            }
          });
        },
      ),
    );
  }

  Future<void> _confirmDelete(BenefitItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text('"${item.description}" 혜택을 삭제하시겠습니까?'),
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
      setState(() {
        mockBenefits[widget.providerId]?.removeWhere((b) => b.id == item.id);
      });
    }
  }

  String _benefitTypeLabel(BenefitType t) {
    switch (t) {
      case BenefitType.discount:
        return '할인';
      case BenefitType.cashback:
        return '캐시백';
      case BenefitType.point:
        return '포인트';
    }
  }

  String _valueLabel(BenefitItem b) {
    if (b.valueType == BenefitValueType.percent) {
      return '${b.value}%';
    } else {
      return '${b.value.toInt()}원';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.providerName} 혜택 관리'),
        backgroundColor: AdminTheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/providers'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        backgroundColor: AdminTheme.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('혜택 추가', style: TextStyle(color: Colors.white)),
      ),
      body: _benefits.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_outline, size: 64, color: AdminTheme.border),
                  SizedBox(height: 16),
                  Text(
                    '등록된 혜택이 없습니다.',
                    style: TextStyle(color: AdminTheme.textSecondary),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _benefits.length,
              itemBuilder: (context, index) {
                final benefit = _benefits[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AdminTheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _valueLabel(benefit),
                        style: const TextStyle(
                          color: AdminTheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    title: Text(
                      benefit.description,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _Chip(
                              label: benefit.categoryName,
                              color: AdminTheme.primary,
                            ),
                            const SizedBox(width: 6),
                            _Chip(
                              label: _benefitTypeLabel(benefit.benefitType),
                              color: AdminTheme.secondary,
                            ),
                            const SizedBox(width: 6),
                            _Chip(
                              label:
                                  benefit.merchantName ?? '업종 전체',
                              color: AdminTheme.textSecondary,
                            ),
                          ],
                        ),
                        if (benefit.condition.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            '조건: ${benefit.condition}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AdminTheme.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: benefit.isActive,
                          onChanged: (v) {
                            setState(() => benefit.isActive = v);
                          },
                          activeThumbColor: AdminTheme.success,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: AdminTheme.primary,
                          ),
                          tooltip: '수정',
                          onPressed: () => _showEditDialog(benefit),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AdminTheme.error,
                          ),
                          onPressed: () => _confirmDelete(benefit),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;

  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _BenefitFormDialog extends StatefulWidget {
  final void Function(BenefitItem) onSave;
  final BenefitItem? existing;

  const _BenefitFormDialog({required this.onSave, this.existing});

  @override
  State<_BenefitFormDialog> createState() => _BenefitFormDialogState();
}

class _BenefitFormDialogState extends State<_BenefitFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _categoryId;
  late String _categoryName;
  late String? _merchantId;
  late String? _merchantName;
  late BenefitType _benefitType;
  late BenefitValueType _valueType;
  late final TextEditingController _valueController;
  late final TextEditingController _descController;
  late final TextEditingController _conditionController;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _categoryId = e?.categoryId ?? _mockCategories[0].$1;
    _categoryName = e?.categoryName ?? _mockCategories[0].$2;
    _merchantId = e?.merchantId;
    _merchantName = e?.merchantName;
    _benefitType = e?.benefitType ?? BenefitType.cashback;
    _valueType = e?.valueType ?? BenefitValueType.percent;
    _valueController = TextEditingController(
      text: e != null ? e.value.toString() : '5',
    );
    _descController = TextEditingController(text: e?.description ?? '');
    _conditionController = TextEditingController(text: e?.condition ?? '');
  }

  @override
  void dispose() {
    _valueController.dispose();
    _descController.dispose();
    _conditionController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    try {
      final benefit = BenefitItem(
        id: widget.existing?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        categoryId: _categoryId,
        categoryName: _categoryName,
        merchantId: _merchantId,
        merchantName: _merchantName,
        benefitType: _benefitType,
        valueType: _valueType,
        value: double.tryParse(_valueController.text) ?? 0,
        description: _descController.text.trim(),
        condition: _conditionController.text.trim(),
        isActive: widget.existing?.isActive ?? true,
      );

      widget.onSave(benefit);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('저장 중 오류가 발생했습니다: $e'),
          backgroundColor: AdminTheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existing != null ? '혜택 수정' : '혜택 추가'),
      content: SizedBox(
        width: 480,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 카테고리
                DropdownButtonFormField<String>(
                  // ignore: deprecated_member_use
                  value: _categoryId,
                  decoration: const InputDecoration(labelText: '카테고리'),
                  items: _mockCategories
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
                      _categoryName = _mockCategories
                          .firstWhere((c) => c.$1 == v)
                          .$2;
                    });
                  },
                ),
                const SizedBox(height: 12),

                // 가맹점 (optional)
                DropdownButtonFormField<String?>(
                  // ignore: deprecated_member_use
                  value: _merchantId,
                  decoration: const InputDecoration(
                    labelText: '가맹점 (선택)',
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('업종 전체'),
                    ),
                    ..._mockMerchants.map(
                      (m) => DropdownMenuItem<String?>(
                        value: m.$1,
                        child: Text(m.$2),
                      ),
                    ),
                  ],
                  onChanged: (v) {
                    setState(() {
                      _merchantId = v;
                      _merchantName = v == null
                          ? null
                          : _mockMerchants.firstWhere((m) => m.$1 == v).$2;
                    });
                  },
                ),
                const SizedBox(height: 12),

                // 혜택 유형
                DropdownButtonFormField<BenefitType>(
                  // ignore: deprecated_member_use
                  value: _benefitType,
                  decoration: const InputDecoration(labelText: '혜택 유형'),
                  items: const [
                    DropdownMenuItem(
                      value: BenefitType.discount,
                      child: Text('할인'),
                    ),
                    DropdownMenuItem(
                      value: BenefitType.cashback,
                      child: Text('캐시백'),
                    ),
                    DropdownMenuItem(
                      value: BenefitType.point,
                      child: Text('포인트'),
                    ),
                  ],
                  onChanged: (v) => setState(() => _benefitType = v!),
                ),
                const SizedBox(height: 12),

                // 혜택값 type toggle + input
                Row(
                  children: [
                    Expanded(
                      child: SegmentedButton<BenefitValueType>(
                        segments: const [
                          ButtonSegment(
                            value: BenefitValueType.percent,
                            label: Text('비율 (%)'),
                          ),
                          ButtonSegment(
                            value: BenefitValueType.fixed,
                            label: Text('정액 (원)'),
                          ),
                        ],
                        selected: {_valueType},
                        onSelectionChanged: (s) {
                          setState(() => _valueType = s.first);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _valueController,
                  decoration: InputDecoration(
                    labelText:
                        _valueType == BenefitValueType.percent ? '비율 (%)' : '금액 (원)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) =>
                      v == null || v.isEmpty ? '값을 입력해주세요.' : null,
                ),
                const SizedBox(height: 12),

                // 설명
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: '설명'),
                  validator: (v) =>
                      v == null || v.isEmpty ? '설명을 입력해주세요.' : null,
                ),
                const SizedBox(height: 12),

                // 조건
                TextFormField(
                  controller: _conditionController,
                  decoration: const InputDecoration(
                    labelText: '조건',
                    hintText: '전월 30만원 이상 사용 시',
                  ),
                ),
              ],
            ),
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
          child: Text(widget.existing != null ? '저장' : '추가'),
        ),
      ],
    );
  }
}
