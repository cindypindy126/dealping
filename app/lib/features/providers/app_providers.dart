import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/models.dart';
import '../../data/services/mock_data_service.dart';

// ─── My Providers state (locally persisted) ───────────────────────────────────

class MyProvidersNotifier extends StateNotifier<List<String>> {
  MyProvidersNotifier() : super([]);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('my_provider_ids') ?? [];
    state = ids;
  }

  Future<void> add(String providerId) async {
    if (state.contains(providerId)) return;
    final updated = [...state, providerId];
    state = updated;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('my_provider_ids', updated);
  }

  Future<void> remove(String providerId) async {
    final updated = state.where((id) => id != providerId).toList();
    state = updated;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('my_provider_ids', updated);
  }

  bool contains(String providerId) => state.contains(providerId);
}

final myProvidersProvider =
    StateNotifierProvider<MyProvidersNotifier, List<String>>((ref) {
  return MyProvidersNotifier();
});

// ─── Search count (자주 검색한 순) ────────────────────────────────────────────

class SearchCountNotifier extends StateNotifier<Map<String, int>> {
  SearchCountNotifier() : super({});

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith('sc_'));
    final map = <String, int>{};
    for (final k in keys) {
      map[k.substring(3)] = prefs.getInt(k) ?? 0;
    }
    state = map;
  }

  Future<void> increment(String merchantId) async {
    final updated = {...state, merchantId: (state[merchantId] ?? 0) + 1};
    state = updated;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('sc_$merchantId', updated[merchantId]!);
  }

  int countOf(String merchantId) => state[merchantId] ?? 0;
}

final searchCountProvider =
    StateNotifierProvider<SearchCountNotifier, Map<String, int>>((ref) {
  return SearchCountNotifier();
});

// ─── Selected category / merchant ────────────────────────────────────────────

final selectedCategoryProvider = StateProvider<String?>((ref) => null);
final selectedMerchantProvider = StateProvider<Merchant?>((ref) => null);

// ─── Matched benefits ─────────────────────────────────────────────────────────

final matchedBenefitsProvider = Provider.family<List<MatchedBenefit>,
    ({String categoryId, String? merchantId})>((ref, params) {
  final registeredIds = ref.watch(myProvidersProvider);
  return MockDataService.matchBenefits(
    registeredProviderIds: registeredIds,
    categoryId: params.categoryId,
    merchantId: params.merchantId,
  );
});
