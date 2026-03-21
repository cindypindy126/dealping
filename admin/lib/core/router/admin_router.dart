import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/providers/providers_screen.dart';
import '../../features/providers/provider_form_screen.dart';
import '../../features/benefits/benefits_screen.dart';
import '../../features/categories/categories_screen.dart';
import '../../features/merchants/merchants_screen.dart';

// Simple mock auth state
bool _isAuthenticated = false;

void setAuthenticated(bool value) {
  _isAuthenticated = value;
}

bool get isAuthenticated => _isAuthenticated;

class AdminRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = _isAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        redirect: (context, state) => '/dashboard',
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/providers',
        builder: (context, state) => const ProvidersScreen(),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) => const ProviderFormScreen(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ProviderFormScreen(providerId: id);
            },
            routes: [
              GoRoute(
                path: 'benefits',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  final providerName =
                      state.uri.queryParameters['name'] ?? '제공자';
                  return BenefitsScreen(
                    providerId: id,
                    providerName: providerName,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: '/merchants',
        builder: (context, state) => const MerchantsScreen(),
      ),
    ],
  );
}
