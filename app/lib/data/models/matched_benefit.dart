import 'package:freezed_annotation/freezed_annotation.dart';
import 'benefit.dart';
import 'benefit_provider.dart';

part 'matched_benefit.freezed.dart';
part 'matched_benefit.g.dart';

@freezed
class MatchedBenefit with _$MatchedBenefit {
  const factory MatchedBenefit({
    required BenefitProvider provider,
    required Benefit benefit,
    @Default(false) bool isMerchantSpecific,
  }) = _MatchedBenefit;

  factory MatchedBenefit.fromJson(Map<String, dynamic> json) =>
      _$MatchedBenefitFromJson(json);
}
