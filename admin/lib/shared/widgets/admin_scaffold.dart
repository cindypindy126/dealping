import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/admin_theme.dart';
import '../../core/router/admin_router.dart';

class AdminScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final int selectedIndex;

  const AdminScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.selectedIndex,
    this.actions,
    this.floatingActionButton,
  });

  static const _navItems = [
    (icon: Icons.dashboard_outlined, label: '대시보드', path: '/dashboard'),
    (icon: Icons.credit_card_outlined, label: '카드/통신사', path: '/providers'),
    (icon: Icons.category_outlined, label: '카테고리', path: '/categories'),
    (icon: Icons.store_outlined, label: '가맹점', path: '/merchants'),
  ];

  void _handleLogout(BuildContext context) {
    setAuthenticated(false);
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AdminTheme.textPrimary,
          ),
        ),
        backgroundColor: AdminTheme.surface,
        actions: [
          ...?actions,
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: '로그아웃',
            onPressed: () => _handleLogout(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                context.go(_navItems[index].path);
              },
              extended: true,
              minExtendedWidth: 200,
              backgroundColor: AdminTheme.surface,
              selectedIconTheme: const IconThemeData(color: AdminTheme.primary),
              selectedLabelTextStyle: const TextStyle(
                color: AdminTheme.primary,
                fontWeight: FontWeight.w600,
              ),
              destinations: _navItems
                  .map(
                    (item) => NavigationRailDestination(
                      icon: Icon(item.icon),
                      label: Text(item.label),
                    ),
                  )
                  .toList(),
            ),
          if (isWide)
            const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: body),
        ],
      ),
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                context.go(_navItems[index].path);
              },
              destinations: _navItems
                  .map(
                    (item) => NavigationDestination(
                      icon: Icon(item.icon),
                      label: item.label,
                    ),
                  )
                  .toList(),
            ),
      floatingActionButton: floatingActionButton,
    );
  }
}
