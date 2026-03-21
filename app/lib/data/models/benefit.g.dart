// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BenefitImpl _$$BenefitImplFromJson(Map<String, dynamic> json) =>
    _$BenefitImpl(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      merchantId: json['merchant_id'] as String?,
      benefitType: json['benefit_type'] as String,
      benefitRate: (json['benefit_rate'] as num?)?.toDouble() ?? 0,
      benefitFixed: (json['benefit_fixed'] as num?)?.toInt(),
      benefitDescription: json['benefit_description'] as String,
      conditions: json['conditions'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$BenefitImplToJson(_$BenefitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'merchant_id': instance.merchantId,
      'benefit_type': instance.benefitType,
      'benefit_rate': instance.benefitRate,
      'benefit_fixed': instance.benefitFixed,
      'benefit_description': instance.benefitDescription,
      'conditions': instance.conditions,
      'is_active': instance.isActive,
    };
