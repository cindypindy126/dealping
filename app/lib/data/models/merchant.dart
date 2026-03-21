import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'merchant.freezed.dart';
part 'merchant.g.dart';

@freezed
class Merchant with _$Merchant {
  const factory Merchant({
    required String id,
    required String name,
    required String categoryId,
    @Default([]) List<String> aliases,
    @Default(true) bool isFranchise,
    @Default(0) int sortOrder,
    @Default(true) bool isActive,
  }) = _Merchant;

  factory Merchant.fromJson(Map<String, dynamic> json) =>
      _$MerchantFromJson(json);

  factory Merchant.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Merchant.fromJson({...data, 'id': doc.id});
  }
}
