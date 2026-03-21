import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/repository_exception.dart';

class UserProviderRepository {
  final FirebaseFirestore _db;

  UserProviderRepository(this._db);

  CollectionReference _myProviders(String uid) {
    assert(uid.isNotEmpty, 'uid must not be empty');
    return _db
        .collection(AppConstants.colUsers)
        .doc(uid)
        .collection(AppConstants.subcolMyProviders);
  }

  Stream<List<UserProvider>> watchUserProviders(String uid) {
    if (uid.isEmpty) return Stream.value([]);
    return _myProviders(uid).snapshots().map(
      (snap) => snap.docs.map(UserProvider.fromFirestore).toList(),
    ).handleError((Object e) {
      // Log error; return empty list to avoid breaking UI
      return <UserProvider>[];
    });
  }

  Future<void> addProvider(String uid, String providerId) async {
    if (uid.isEmpty) return;
    try {
      await _myProviders(uid).doc(providerId).set({
        'provider_id': providerId,
        'added_at': FieldValue.serverTimestamp(),
        'nickname': '',
      });
    } on FirebaseException catch (e) {
      throw RepositoryException('Failed to add provider: ${e.message}', e);
    }
  }

  Future<void> removeProvider(String uid, String providerId) async {
    if (uid.isEmpty) return;
    try {
      await _myProviders(uid).doc(providerId).delete();
    } on FirebaseException catch (e) {
      throw RepositoryException('Failed to remove provider: ${e.message}', e);
    }
  }

  Future<List<String>> getProviderIds(String uid) async {
    if (uid.isEmpty) return [];
    try {
      final snap = await _myProviders(uid).get();
      return snap.docs.map((d) => d.id).toList();
    } on FirebaseException catch (e) {
      throw RepositoryException('Failed to get provider IDs: ${e.message}', e);
    }
  }
}

final userProviderRepositoryProvider = Provider<UserProviderRepository>(
  (ref) => UserProviderRepository(FirebaseFirestore.instance),
);
