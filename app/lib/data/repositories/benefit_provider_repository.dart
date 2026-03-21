import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/repository_exception.dart';

class BenefitProviderRepository {
  final FirebaseFirestore _db;

  BenefitProviderRepository(this._db);

  Future<List<BenefitProvider>> getAll() async {
    try {
      final snap = await _db
          .collection(AppConstants.colBenefitProviders)
          .where('is_active', isEqualTo: true)
          .get();
      return snap.docs.map(BenefitProvider.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw RepositoryException('Failed to load providers: ${e.message}', e);
    }
  }

  Future<BenefitProvider?> getById(String id) async {
    try {
      final doc = await _db
          .collection(AppConstants.colBenefitProviders)
          .doc(id)
          .get();
      if (!doc.exists) return null;
      final provider = BenefitProvider.fromFirestore(doc);
      return provider.isActive ? provider : null;
    } on FirebaseException catch (e) {
      throw RepositoryException('Failed to load provider $id: ${e.message}', e);
    }
  }

  Future<List<BenefitProvider>> search(String query) async {
    final lower = query.toLowerCase();
    final all = await getAll();
    return all
        .where((p) =>
            p.name.toLowerCase().contains(lower) ||
            p.issuerName.toLowerCase().contains(lower))
        .toList();
  }

  Future<List<Benefit>> getBenefits(String providerId) async {
    try {
      final snap = await _db
          .collection(AppConstants.colBenefitProviders)
          .doc(providerId)
          .collection(AppConstants.subcolBenefits)
          .where('is_active', isEqualTo: true)
          .get();
      return snap.docs.map(Benefit.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw RepositoryException('Failed to load benefits for $providerId: ${e.message}', e);
    }
  }

  Future<List<Tier>> getTiers(String providerId) async {
    try {
      final snap = await _db
          .collection(AppConstants.colBenefitProviders)
          .doc(providerId)
          .collection(AppConstants.subcolTiers)
          .orderBy('min_spend')
          .get();
      return snap.docs.map(Tier.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw RepositoryException('Failed to load tiers for $providerId: ${e.message}', e);
    }
  }
}

final benefitProviderRepositoryProvider = Provider<BenefitProviderRepository>(
  (ref) => BenefitProviderRepository(FirebaseFirestore.instance),
);
