// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProviderImpl _$$UserProviderImplFromJson(Map<String, dynamic> json) =>
    _$UserProviderImpl(
      providerId: json['provider_id'] as String,
      nickname: json['nickname'] as String? ?? '',
    );

Map<String, dynamic> _$$UserProviderImplToJson(_$UserProviderImpl instance) =>
    <String, dynamic>{
      'provider_id': instance.providerId,
      'nickname': instance.nickname,
    };
