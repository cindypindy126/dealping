import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'benefit_provider.freezed.dart';
part 'benefit_provider.g.dart';

@freezed
class BenefitProvider with _$BenefitProvider {
  const factory BenefitProvider({
    required String id,
    required String name,
    required String providerType,
    String? cardType,
    required String issuer,
    required String issuerName,
    @Default(0) int annualFee,
    @Default('') String imageUrl,
    @Default(true) bool isActive,
  }) = _BenefitProvider;

  factory BenefitProvider.fromJson(Map<String, dynamic> json) =>
      _$BenefitProviderFromJson(json);

  factory BenefitProvider.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BenefitProvider.fromJson({...data, 'id': doc.id});
  }
}
