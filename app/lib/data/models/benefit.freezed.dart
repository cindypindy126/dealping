// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'benefit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Benefit _$BenefitFromJson(Map<String, dynamic> json) {
  return _Benefit.fromJson(json);
}

/// @nodoc
mixin _$Benefit {
  String get id => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String? get merchantId => throw _privateConstructorUsedError;
  String get benefitType => throw _privateConstructorUsedError;
  double get benefitRate => throw _privateConstructorUsedError;
  int? get benefitFixed => throw _privateConstructorUsedError;
  String get benefitDescription => throw _privateConstructorUsedError;
  String get conditions => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BenefitCopyWith<Benefit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BenefitCopyWith<$Res> {
  factory $BenefitCopyWith(Benefit value, $Res Function(Benefit) then) =
      _$BenefitCopyWithImpl<$Res, Benefit>;
  @useResult
  $Res call(
      {String id,
      String categoryId,
      String? merchantId,
      String benefitType,
      double benefitRate,
      int? benefitFixed,
      String benefitDescription,
      String conditions,
      bool isActive});
}

/// @nodoc
class _$BenefitCopyWithImpl<$Res, $Val extends Benefit>
    implements $BenefitCopyWith<$Res> {
  _$BenefitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = null,
    Object? merchantId = freezed,
    Object? benefitType = null,
    Object? benefitRate = null,
    Object? benefitFixed = freezed,
    Object? benefitDescription = null,
    Object? conditions = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      merchantId: freezed == merchantId
          ? _value.merchantId
          : merchantId // ignore: cast_nullable_to_non_nullable
              as String?,
      benefitType: null == benefitType
          ? _value.benefitType
          : benefitType // ignore: cast_nullable_to_non_nullable
              as String,
      benefitRate: null == benefitRate
          ? _value.benefitRate
          : benefitRate // ignore: cast_nullable_to_non_nullable
              as double,
      benefitFixed: freezed == benefitFixed
          ? _value.benefitFixed
          : benefitFixed // ignore: cast_nullable_to_non_nullable
              as int?,
      benefitDescription: null == benefitDescription
          ? _value.benefitDescription
          : benefitDescription // ignore: cast_nullable_to_non_nullable
              as String,
      conditions: null == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BenefitImplCopyWith<$Res> implements $BenefitCopyWith<$Res> {
  factory _$$BenefitImplCopyWith(
          _$BenefitImpl value, $Res Function(_$BenefitImpl) then) =
      __$$BenefitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String categoryId,
      String? merchantId,
      String benefitType,
      double benefitRate,
      int? benefitFixed,
      String benefitDescription,
      String conditions,
      bool isActive});
}

/// @nodoc
class __$$BenefitImplCopyWithImpl<$Res>
    extends _$BenefitCopyWithImpl<$Res, _$BenefitImpl>
    implements _$$BenefitImplCopyWith<$Res> {
  __$$BenefitImplCopyWithImpl(
      _$BenefitImpl _value, $Res Function(_$BenefitImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = null,
    Object? merchantId = freezed,
    Object? benefitType = null,
    Object? benefitRate = null,
    Object? benefitFixed = freezed,
    Object? benefitDescription = null,
    Object? conditions = null,
    Object? isActive = null,
  }) {
    return _then(_$BenefitImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      merchantId: freezed == merchantId
          ? _value.merchantId
          : merchantId // ignore: cast_nullable_to_non_nullable
              as String?,
      benefitType: null == benefitType
          ? _value.benefitType
          : benefitType // ignore: cast_nullable_to_non_nullable
              as String,
      benefitRate: null == benefitRate
          ? _value.benefitRate
          : benefitRate // ignore: cast_nullable_to_non_nullable
              as double,
      benefitFixed: freezed == benefitFixed
          ? _value.benefitFixed
          : benefitFixed // ignore: cast_nullable_to_non_nullable
              as int?,
      benefitDescription: null == benefitDescription
          ? _value.benefitDescription
          : benefitDescription // ignore: cast_nullable_to_non_nullable
              as String,
      conditions: null == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BenefitImpl implements _Benefit {
  const _$BenefitImpl(
      {required this.id,
      required this.categoryId,
      this.merchantId,
      required this.benefitType,
      this.benefitRate = 0,
      this.benefitFixed,
      required this.benefitDescription,
      this.conditions = '',
      this.isActive = true});

  factory _$BenefitImpl.fromJson(Map<String, dynamic> json) =>
      _$$BenefitImplFromJson(json);

  @override
  final String id;
  @override
  final String categoryId;
  @override
  final String? merchantId;
  @override
  final String benefitType;
  @override
  @JsonKey()
  final double benefitRate;
  @override
  final int? benefitFixed;
  @override
  final String benefitDescription;
  @override
  @JsonKey()
  final String conditions;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'Benefit(id: $id, categoryId: $categoryId, merchantId: $merchantId, benefitType: $benefitType, benefitRate: $benefitRate, benefitFixed: $benefitFixed, benefitDescription: $benefitDescription, conditions: $conditions, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BenefitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.merchantId, merchantId) ||
                other.merchantId == merchantId) &&
            (identical(other.benefitType, benefitType) ||
                other.benefitType == benefitType) &&
            (identical(other.benefitRate, benefitRate) ||
                other.benefitRate == benefitRate) &&
            (identical(other.benefitFixed, benefitFixed) ||
                other.benefitFixed == benefitFixed) &&
            (identical(other.benefitDescription, benefitDescription) ||
                other.benefitDescription == benefitDescription) &&
            (identical(other.conditions, conditions) ||
                other.conditions == conditions) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      categoryId,
      merchantId,
      benefitType,
      benefitRate,
      benefitFixed,
      benefitDescription,
      conditions,
      isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BenefitImplCopyWith<_$BenefitImpl> get copyWith =>
      __$$BenefitImplCopyWithImpl<_$BenefitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BenefitImplToJson(
      this,
    );
  }
}

abstract class _Benefit implements Benefit {
  const factory _Benefit(
      {required final String id,
      required final String categoryId,
      final String? merchantId,
      required final String benefitType,
      final double benefitRate,
      final int? benefitFixed,
      required final String benefitDescription,
      final String conditions,
      final bool isActive}) = _$BenefitImpl;

  factory _Benefit.fromJson(Map<String, dynamic> json) = _$BenefitImpl.fromJson;

  @override
  String get id;
  @override
  String get categoryId;
  @override
  String? get merchantId;
  @override
  String get benefitType;
  @override
  double get benefitRate;
  @override
  int? get benefitFixed;
  @override
  String get benefitDescription;
  @override
  String get conditions;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$BenefitImplCopyWith<_$BenefitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
