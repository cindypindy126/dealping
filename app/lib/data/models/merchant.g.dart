// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MerchantImpl _$$MerchantImplFromJson(Map<String, dynamic> json) =>
    _$MerchantImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['category_id'] as String,
      aliases: (json['aliases'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isFranchise: json['is_franchise'] as bool? ?? true,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$MerchantImplToJson(_$MerchantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category_id': instance.categoryId,
      'aliases': instance.aliases,
      'is_franchise': instance.isFranchise,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
    };
