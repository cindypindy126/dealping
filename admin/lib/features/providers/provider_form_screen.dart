import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/admin_theme.dart';
import 'providers_screen.dart';

class ProviderFormScreen extends StatefulWidget {
  final String? providerId;

  const ProviderFormScreen({super.key, this.providerId});

  @override
  State<ProviderFormScreen> createState() => _ProviderFormScreenState();
}

class _ProviderFormScreenState extends State<ProviderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Form fields
  final _nameController = TextEditingController();
  final _issuerCodeController = TextEditingController();
  final _issuerNameController = TextEditingController();
  final _annualFeeController = TextEditingController(text: '0');
  String _providerType = 'card';
  String? _cardType = 'credit';
  bool _isActive = true;

  bool get _isEditMode => widget.providerId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      _loadExistingData();
    }
  }

  void _loadExistingData() {
    final item = mockProviders.where((p) => p.id == widget.providerId).firstOrNull;
    if (item != null) {
      _nameController.text = item.name;
      _issuerCodeController.text = item.issuerCode;
      _issuerNameController.text = item.issuerName;
      _annualFeeController.text = item.annualFee.toString();
      _providerType = item.providerType;
      _cardType = item.cardType;
      _isActive = item.isActive;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _issuerCodeController.dispose();
    _issuerNameController.dispose();
    _annualFeeController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 600));

    if (_isEditMode) {
      // Update existing
      final index = mockProviders.indexWhere((p) => p.id == widget.providerId);
      if (index != -1) {
        mockProviders[index] = ProviderItem(
          id: widget.providerId!,
          name: _nameController.text.trim(),
          providerType: _providerType,
          cardType: _providerType == 'card' ? _cardType : null,
          issuerCode: _issuerCodeController.text.trim(),
          issuerName: _issuerNameController.text.trim(),
          annualFee: int.tryParse(_annualFeeController.text) ?? 0,
          isActive: _isActive,
        );
      }
    } else {
      // Create new
      final newId = (mockProviders.length + 1).toString();
      mockProviders.add(
        ProviderItem(
          id: newId,
          name: _nameController.text.trim(),
          providerType: _providerType,
          cardType: _providerType == 'card' ? _cardType : null,
          issuerCode: _issuerCodeController.text.trim(),
          issuerName: _issuerNameController.text.trim(),
          annualFee: int.tryParse(_annualFeeController.text) ?? 0,
          isActive: _isActive,
        ),
      );
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEditMode ? '수정되었습니다.' : '추가되었습니다.'),
          backgroundColor: AdminTheme.success,
        ),
      );
      context.go('/providers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? '카드/통신사 편집' : '카드/통신사 추가'),
        backgroundColor: AdminTheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/providers'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '기본 정보',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AdminTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 이름
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: '이름 *'),
                        validator: (v) =>
                            v == null || v.isEmpty ? '이름을 입력해주세요.' : null,
                      ),
                      const SizedBox(height: 16),

                      // 제공자 유형
                      DropdownButtonFormField<String>(
                        // ignore: deprecated_member_use
                        value: _providerType,
                        decoration: const InputDecoration(
                          labelText: '제공자 유형',
                        ),
                        items: const [
                          DropdownMenuItem(value: 'card', child: Text('카드')),
                          DropdownMenuItem(
                            value: 'telecom',
                            child: Text('통신사'),
                          ),
                        ],
                        onChanged: (v) {
                          setState(() {
                            _providerType = v!;
                            if (_providerType == 'telecom') {
                              _cardType = null;
                            } else {
                              _cardType = 'credit';
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // 카드 유형 (only when type = card)
                      if (_providerType == 'card') ...[
                        DropdownButtonFormField<String>(
                          // ignore: deprecated_member_use
                          value: _cardType,
                          decoration: const InputDecoration(
                            labelText: '카드 유형',
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'credit',
                              child: Text('신용카드'),
                            ),
                            DropdownMenuItem(
                              value: 'debit',
                              child: Text('체크카드'),
                            ),
                          ],
                          onChanged: (v) => setState(() => _cardType = v),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // 발급사 코드
                      TextFormField(
                        controller: _issuerCodeController,
                        decoration: const InputDecoration(
                          labelText: '발급사 코드',
                          hintText: 'e.g. SHINHAN, KB, SKT',
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? '발급사 코드를 입력해주세요.' : null,
                      ),
                      const SizedBox(height: 16),

                      // 발급사 이름
                      TextFormField(
                        controller: _issuerNameController,
                        decoration: const InputDecoration(
                          labelText: '발급사 이름',
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? '발급사 이름을 입력해주세요.' : null,
                      ),
                      const SizedBox(height: 16),

                      // 연회비
                      TextFormField(
                        controller: _annualFeeController,
                        decoration: const InputDecoration(
                          labelText: '연회비 (원)',
                          hintText: '0',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: 16),

                      // 활성화
                      Row(
                        children: [
                          const Text(
                            '활성화',
                            style: TextStyle(
                              fontSize: 16,
                              color: AdminTheme.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: _isActive,
                            onChanged: (v) => setState(() => _isActive = v),
                            activeThumbColor: AdminTheme.success,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => context.go('/providers'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: const Text('취소'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: FilledButton(
                              onPressed: _isLoading ? null : _handleSubmit,
                              style: FilledButton.styleFrom(
                                backgroundColor: AdminTheme.primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(_isEditMode ? '수정' : '추가'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
