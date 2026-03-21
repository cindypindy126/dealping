// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefit_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BenefitProviderImpl _$$BenefitProviderImplFromJson(
        Map<String, dynamic> json) =>
    _$BenefitProviderImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      providerType: json['provider_type'] as String,
      cardType: json['card_type'] as String?,
      issuer: json['issuer'] as String,
      issuerName: json['issuer_name'] as String,
      annualFee: (json['annual_fee'] as num?)?.toInt() ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$BenefitProviderImplToJson(
        _$BenefitProviderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'provider_type': instance.providerType,
      'card_type': instance.cardType,
      'issuer': instance.issuer,
      'issuer_name': instance.issuerName,
      'annual_fee': instance.annualFee,
      'image_url': instance.imageUrl,
      'is_active': instance.isActive,
    };
