import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/providers/app_providers.dart';

class DealPingApp extends ConsumerStatefulWidget {
  const DealPingApp({super.key});

  @override
  ConsumerState<DealPingApp> createState() => _DealPingAppState();
}

class _DealPingAppState extends ConsumerState<DealPingApp> {
  @override
  void initState() {
    super.initState();
    // Load persisted card list from SharedPreferences on startup
    Future.microtask(() => ref.read(myProvidersProvider.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dealping',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
