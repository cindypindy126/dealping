// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TierImpl _$$TierImplFromJson(Map<String, dynamic> json) => _$TierImpl(
      id: json['id'] as String,
      minSpend: (json['min_spend'] as num).toInt(),
      maxSpend: (json['max_spend'] as num?)?.toInt(),
      monthlyDiscountLimit: (json['monthly_discount_limit'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$$TierImplToJson(_$TierImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'min_spend': instance.minSpend,
      'max_spend': instance.maxSpend,
      'monthly_discount_limit': instance.monthlyDiscountLimit,
      'description': instance.description,
    };
