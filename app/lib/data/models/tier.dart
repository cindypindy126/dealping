import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'tier.freezed.dart';
part 'tier.g.dart';

@freezed
class Tier with _$Tier {
  const factory Tier({
    required String id,
    required int minSpend,
    int? maxSpend,
    required int monthlyDiscountLimit,
    required String description,
  }) = _Tier;

  factory Tier.fromJson(Map<String, dynamic> json) => _$TierFromJson(json);

  factory Tier.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Tier.fromJson({...data, 'id': doc.id});
  }
}
