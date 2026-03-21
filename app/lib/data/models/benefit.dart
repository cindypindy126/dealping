import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'benefit.freezed.dart';
part 'benefit.g.dart';

@freezed
class Benefit with _$Benefit {
  const factory Benefit({
    required String id,
    required String categoryId,
    String? merchantId,
    required String benefitType,
    @Default(0) double benefitRate,
    int? benefitFixed,
    required String benefitDescription,
    @Default('') String conditions,
    @Default(true) bool isActive,
  }) = _Benefit;

  factory Benefit.fromJson(Map<String, dynamic> json) =>
      _$BenefitFromJson(json);

  factory Benefit.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Benefit.fromJson({...data, 'id': doc.id});
  }
}
