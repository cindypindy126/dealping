// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Tier _$TierFromJson(Map<String, dynamic> json) {
  return _Tier.fromJson(json);
}

/// @nodoc
mixin _$Tier {
  String get id => throw _privateConstructorUsedError;
  int get minSpend => throw _privateConstructorUsedError;
  int? get maxSpend => throw _privateConstructorUsedError;
  int get monthlyDiscountLimit => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TierCopyWith<Tier> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TierCopyWith<$Res> {
  factory $TierCopyWith(Tier value, $Res Function(Tier) then) =
      _$TierCopyWithImpl<$Res, Tier>;
  @useResult
  $Res call(
      {String id,
      int minSpend,
      int? maxSpend,
      int monthlyDiscountLimit,
      String description});
}

/// @nodoc
class _$TierCopyWithImpl<$Res, $Val extends Tier>
    implements $TierCopyWith<$Res> {
  _$TierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? minSpend = null,
    Object? maxSpend = freezed,
    Object? monthlyDiscountLimit = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      minSpend: null == minSpend
          ? _value.minSpend
          : minSpend // ignore: cast_nullable_to_non_nullable
              as int,
      maxSpend: freezed == maxSpend
          ? _value.maxSpend
          : maxSpend // ignore: cast_nullable_to_non_nullable
              as int?,
      monthlyDiscountLimit: null == monthlyDiscountLimit
          ? _value.monthlyDiscountLimit
          : monthlyDiscountLimit // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TierImplCopyWith<$Res> implements $TierCopyWith<$Res> {
  factory _$$TierImplCopyWith(
          _$TierImpl value, $Res Function(_$TierImpl) then) =
      __$$TierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int minSpend,
      int? maxSpend,
      int monthlyDiscountLimit,
      String description});
}

/// @nodoc
class __$$TierImplCopyWithImpl<$Res>
    extends _$TierCopyWithImpl<$Res, _$TierImpl>
    implements _$$TierImplCopyWith<$Res> {
  __$$TierImplCopyWithImpl(_$TierImpl _value, $Res Function(_$TierImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? minSpend = null,
    Object? maxSpend = freezed,
    Object? monthlyDiscountLimit = null,
    Object? description = null,
  }) {
    return _then(_$TierImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      minSpend: null == minSpend
          ? _value.minSpend
          : minSpend // ignore: cast_nullable_to_non_nullable
              as int,
      maxSpend: freezed == maxSpend
          ? _value.maxSpend
          : maxSpend // ignore: cast_nullable_to_non_nullable
              as int?,
      monthlyDiscountLimit: null == monthlyDiscountLimit
          ? _value.monthlyDiscountLimit
          : monthlyDiscountLimit // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TierImpl implements _Tier {
  const _$TierImpl(
      {required this.id,
      required this.minSpend,
      this.maxSpend,
      required this.monthlyDiscountLimit,
      required this.description});

  factory _$TierImpl.fromJson(Map<String, dynamic> json) =>
      _$$TierImplFromJson(json);

  @override
  final String id;
  @override
  final int minSpend;
  @override
  final int? maxSpend;
  @override
  final int monthlyDiscountLimit;
  @override
  final String description;

  @override
  String toString() {
    return 'Tier(id: $id, minSpend: $minSpend, maxSpend: $maxSpend, monthlyDiscountLimit: $monthlyDiscountLimit, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TierImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.minSpend, minSpend) ||
                other.minSpend == minSpend) &&
            (identical(other.maxSpend, maxSpend) ||
                other.maxSpend == maxSpend) &&
            (identical(other.monthlyDiscountLimit, monthlyDiscountLimit) ||
                other.monthlyDiscountLimit == monthlyDiscountLimit) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, minSpend, maxSpend, monthlyDiscountLimit, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TierImplCopyWith<_$TierImpl> get copyWith =>
      __$$TierImplCopyWithImpl<_$TierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TierImplToJson(
      this,
    );
  }
}

abstract class _Tier implements Tier {
  const factory _Tier(
      {required final String id,
      required final int minSpend,
      final int? maxSpend,
      required final int monthlyDiscountLimit,
      required final String description}) = _$TierImpl;

  factory _Tier.fromJson(Map<String, dynamic> json) = _$TierImpl.fromJson;

  @override
  String get id;
  @override
  int get minSpend;
  @override
  int? get maxSpend;
  @override
  int get monthlyDiscountLimit;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$TierImplCopyWith<_$TierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
