// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matched_benefit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchedBenefitImpl _$$MatchedBenefitImplFromJson(Map<String, dynamic> json) =>
    _$MatchedBenefitImpl(
      provider:
          BenefitProvider.fromJson(json['provider'] as Map<String, dynamic>),
      benefit: Benefit.fromJson(json['benefit'] as Map<String, dynamic>),
      isMerchantSpecific: json['is_merchant_specific'] as bool? ?? false,
    );

Map<String, dynamic> _$$MatchedBenefitImplToJson(
        _$MatchedBenefitImpl instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'benefit': instance.benefit,
      'is_merchant_specific': instance.isMerchantSpecific,
    };
