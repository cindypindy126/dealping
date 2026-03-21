import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/admin_theme.dart';
import '../../shared/widgets/admin_scaffold.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '대시보드',
      selectedIndex: 0,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '개요',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AdminTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _StatCardsGrid(),
            const SizedBox(height: 32),
            const Text(
              '빠른 이동',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AdminTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _QuickLinks(),
          ],
        ),
      ),
    );
  }
}

class _StatCardsGrid extends StatelessWidget {
  // Mock data — will be replaced with Firestore queries
  final _stats = const [
    _StatData(
      label: '등록 카드/통신사',
      value: '12',
      icon: Icons.credit_card,
      color: Color(0xFF6C63FF),
      path: '/providers',
    ),
    _StatData(
      label: '가맹점 수',
      value: '84',
      icon: Icons.store,
      color: Color(0xFFFF6B9D),
      path: '/merchants',
    ),
    _StatData(
      label: '카테고리 수',
      value: '8',
      icon: Icons.category,
      color: Color(0xFF10B981),
      path: '/categories',
    ),
    _StatData(
      label: '총 혜택 수',
      value: '237',
      icon: Icons.star,
      color: Color(0xFFF59E0B),
      path: '/providers',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 800
            ? 4
            : constraints.maxWidth >= 500
                ? 2
                : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.6,
          ),
          itemCount: _stats.length,
          itemBuilder: (context, index) => _StatCard(data: _stats[index]),
        );
      },
    );
  }
}

class _StatData {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String path;

  const _StatData({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.path,
  });
}

class _StatCard extends StatelessWidget {
  final _StatData data;

  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(data.path),
      borderRadius: BorderRadius.circular(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.label,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AdminTheme.textSecondary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: data.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(data.icon, color: data.color, size: 20),
                  ),
                ],
              ),
              Text(
                data.value,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AdminTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickLinks extends StatelessWidget {
  final _links = const [
    _LinkData(
      label: '카드/통신사 관리',
      description: '카드 및 통신사 정보를 추가하고 편집합니다.',
      icon: Icons.credit_card,
      path: '/providers',
    ),
    _LinkData(
      label: '카테고리 관리',
      description: '혜택 카테고리를 관리하고 정렬 순서를 조정합니다.',
      icon: Icons.category,
      path: '/categories',
    ),
    _LinkData(
      label: '가맹점 관리',
      description: '가맹점 정보 및 별칭을 등록하고 관리합니다.',
      icon: Icons.store,
      path: '/merchants',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _links
          .map(
            (link) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AdminTheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(link.icon, color: AdminTheme.primary),
                ),
                title: Text(
                  link.label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(link.description),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => context.go(link.path),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _LinkData {
  final String label;
  final String description;
  final IconData icon;
  final String path;

  const _LinkData({
    required this.label,
    required this.description,
    required this.icon,
    required this.path,
  });
}
