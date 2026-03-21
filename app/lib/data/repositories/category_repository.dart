import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/repository_exception.dart';

class CategoryRepository {
  final FirebaseFirestore _db;

  CategoryRepository(this._db);

  Future<List<Category>> getAll() async {
    try {
      final snap = await _db
          .collection(AppConstants.colCategories)
          .where('is_active', isEqualTo: true)
          .orderBy('sort_order')
          .get();
      return snap.docs.map(Category.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw RepositoryException('Failed to load categories: ${e.message}', e);
    }
  }
}

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepository(FirebaseFirestore.instance),
);
