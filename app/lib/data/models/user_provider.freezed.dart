// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProvider _$UserProviderFromJson(Map<String, dynamic> json) {
  return _UserProvider.fromJson(json);
}

/// @nodoc
mixin _$UserProvider {
  String get providerId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProviderCopyWith<UserProvider> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProviderCopyWith<$Res> {
  factory $UserProviderCopyWith(
          UserProvider value, $Res Function(UserProvider) then) =
      _$UserProviderCopyWithImpl<$Res, UserProvider>;
  @useResult
  $Res call({String providerId, String nickname});
}

/// @nodoc
class _$UserProviderCopyWithImpl<$Res, $Val extends UserProvider>
    implements $UserProviderCopyWith<$Res> {
  _$UserProviderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? nickname = null,
  }) {
    return _then(_value.copyWith(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProviderImplCopyWith<$Res>
    implements $UserProviderCopyWith<$Res> {
  factory _$$UserProviderImplCopyWith(
          _$UserProviderImpl value, $Res Function(_$UserProviderImpl) then) =
      __$$UserProviderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String providerId, String nickname});
}

/// @nodoc
class __$$UserProviderImplCopyWithImpl<$Res>
    extends _$UserProviderCopyWithImpl<$Res, _$UserProviderImpl>
    implements _$$UserProviderImplCopyWith<$Res> {
  __$$UserProviderImplCopyWithImpl(
      _$UserProviderImpl _value, $Res Function(_$UserProviderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providerId = null,
    Object? nickname = null,
  }) {
    return _then(_$UserProviderImpl(
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProviderImpl implements _UserProvider {
  const _$UserProviderImpl({required this.providerId, this.nickname = ''});

  factory _$UserProviderImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProviderImplFromJson(json);

  @override
  final String providerId;
  @override
  @JsonKey()
  final String nickname;

  @override
  String toString() {
    return 'UserProvider(providerId: $providerId, nickname: $nickname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProviderImpl &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, providerId, nickname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProviderImplCopyWith<_$UserProviderImpl> get copyWith =>
      __$$UserProviderImplCopyWithImpl<_$UserProviderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProviderImplToJson(
      this,
    );
  }
}

abstract class _UserProvider implements UserProvider {
  const factory _UserProvider(
      {required final String providerId,
      final String nickname}) = _$UserProviderImpl;

  factory _UserProvider.fromJson(Map<String, dynamic> json) =
      _$UserProviderImpl.fromJson;

  @override
  String get providerId;
  @override
  String get nickname;
  @override
  @JsonKey(ignore: true)
  _$$UserProviderImplCopyWith<_$UserProviderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
