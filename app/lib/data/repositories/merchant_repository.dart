import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/repository_exception.dart';

class MerchantRepository {
  final FirebaseFirestore _db;

  MerchantRepository(this._db);

  Future<List<Merchant>> getByCategory(String categoryId) async {
    try {
      final snap = await _db
          .collection(AppConstants.colMerchants)
          .where('category_id', isEqualTo: categoryId)
          .where('is_active', isEqualTo: true)
          .orderBy('sort_order')
          .get();
      return snap.docs.map(Merchant.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw RepositoryException('Failed to load merchants for category $categoryId: ${e.message}', e);
    }
  }

  Future<List<Merchant>> search(String query) async {
    try {
      final lower = query.toLowerCase();
      final snap = await _db
          .collection(AppConstants.colMerchants)
          .where('is_active', isEqualTo: true)
          .get();
      return snap.docs
          .map(Merchant.fromFirestore)
          .where((m) =>
              m.name.toLowerCase().contains(lower) ||
              m.aliases.any((a) => a.toLowerCase().contains(lower)))
          .toList();
    } on FirebaseException catch (e) {
      throw RepositoryException('Failed to search merchants: ${e.message}', e);
    }
  }
}

final merchantRepositoryProvider = Provider<MerchantRepository>(
  (ref) => MerchantRepository(FirebaseFirestore.instance),
);
