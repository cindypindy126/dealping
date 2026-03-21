import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/models.dart';
import '../../data/services/mock_data_service.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Merchant> get _results {
    if (_query.trim().isEmpty) return MockDataService.merchants;
    final lower = _query.toLowerCase();
    return MockDataService.merchants.where((m) {
      if (m.name.toLowerCase().contains(lower)) return true;
      return m.aliases.any((a) => a.toLowerCase().contains(lower));
    }).toList();
  }

  String _categoryName(String categoryId) {
    return MockDataService.getCategory(categoryId)?.name ?? categoryId;
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          style: AppTextStyles.bodyLarge,
          decoration: InputDecoration(
            hintText: '가맹점을 검색하세요',
            hintStyle:
                AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
            border: InputBorder.none,
            suffixIcon: _query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.textSecondary),
                    onPressed: () {
                      _controller.clear();
                      setState(() => _query = '');
                    },
                  )
                : null,
          ),
          onChanged: (value) => setState(() => _query = value),
        ),
      ),
      body: results.isEmpty
          ? Center(
              child: Text('검색 결과가 없습니다',
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary)),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: results.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, indent: 16, endIndent: 16),
              itemBuilder: (context, i) {
                final merchant = results[i];
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.store_outlined,
                        color: AppColors.primary, size: 20),
                  ),
                  title: Text(merchant.name, style: AppTextStyles.bodyMedium),
                  subtitle: Text(
                    merchant.aliases.isNotEmpty
                        ? merchant.aliases.join(', ')
                        : '',
                    style: AppTextStyles.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _categoryName(merchant.categoryId),
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary),
                    ),
                  ),
                  onTap: () {
                    context.push(
                      '/category/${merchant.categoryId}',
                      extra: merchant,
                    );
                  },
                );
              },
            ),
    );
  }
}
