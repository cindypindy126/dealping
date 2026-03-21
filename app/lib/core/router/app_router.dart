import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/models.dart';
import '../../features/auth/onboarding_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/home/main_shell.dart';
import '../../features/my_cards/my_cards_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/search/search_screen.dart';
import '../../features/category/category_detail_screen.dart';
import '../../features/provider_detail/provider_detail_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) async {
      final path = state.uri.toString();
      // Redirect root and /home to onboarding if not yet done
      if (path == '/' || path == '/home') {
        final prefs = await SharedPreferences.getInstance();
        final done = prefs.getBool('onboarding_done') ?? false;
        if (!done) return '/onboarding';
        if (path == '/') return '/home';
      }
      return null;
    },
    routes: [
      // Onboarding
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Search (outside shell — full-screen)
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),

      // Category detail (outside shell — full-screen)
      GoRoute(
        path: '/category/:categoryId',
        builder: (context, state) {
          final categoryId = state.pathParameters['categoryId']!;
          final merchant = state.extra as Merchant?;
          return CategoryDetailScreen(
            categoryId: categoryId,
            initialMerchant: merchant,
          );
        },
      ),

      // Provider detail (outside shell — full-screen)
      GoRoute(
        path: '/provider/:providerId',
        builder: (context, state) {
          final providerId = state.pathParameters['providerId']!;
          return ProviderDetailScreen(providerId: providerId);
        },
      ),

      // Shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/my-cards',
            builder: (context, state) => const MyCardsScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),

      // Splash screen
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Root redirect placeholder
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
    ],
  );
}
