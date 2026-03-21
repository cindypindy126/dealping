// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matched_benefit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatchedBenefit _$MatchedBenefitFromJson(Map<String, dynamic> json) {
  return _MatchedBenefit.fromJson(json);
}

/// @nodoc
mixin _$MatchedBenefit {
  BenefitProvider get provider => throw _privateConstructorUsedError;
  Benefit get benefit => throw _privateConstructorUsedError;
  bool get isMerchantSpecific => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchedBenefitCopyWith<MatchedBenefit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchedBenefitCopyWith<$Res> {
  factory $MatchedBenefitCopyWith(
          MatchedBenefit value, $Res Function(MatchedBenefit) then) =
      _$MatchedBenefitCopyWithImpl<$Res, MatchedBenefit>;
  @useResult
  $Res call(
      {BenefitProvider provider, Benefit benefit, bool isMerchantSpecific});

  $BenefitProviderCopyWith<$Res> get provider;
  $BenefitCopyWith<$Res> get benefit;
}

/// @nodoc
class _$MatchedBenefitCopyWithImpl<$Res, $Val extends MatchedBenefit>
    implements $MatchedBenefitCopyWith<$Res> {
  _$MatchedBenefitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
    Object? benefit = null,
    Object? isMerchantSpecific = null,
  }) {
    return _then(_value.copyWith(
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as BenefitProvider,
      benefit: null == benefit
          ? _value.benefit
          : benefit // ignore: cast_nullable_to_non_nullable
              as Benefit,
      isMerchantSpecific: null == isMerchantSpecific
          ? _value.isMerchantSpecific
          : isMerchantSpecific // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BenefitProviderCopyWith<$Res> get provider {
    return $BenefitProviderCopyWith<$Res>(_value.provider, (value) {
      return _then(_value.copyWith(provider: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BenefitCopyWith<$Res> get benefit {
    return $BenefitCopyWith<$Res>(_value.benefit, (value) {
      return _then(_value.copyWith(benefit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchedBenefitImplCopyWith<$Res>
    implements $MatchedBenefitCopyWith<$Res> {
  factory _$$MatchedBenefitImplCopyWith(_$MatchedBenefitImpl value,
          $Res Function(_$MatchedBenefitImpl) then) =
      __$$MatchedBenefitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BenefitProvider provider, Benefit benefit, bool isMerchantSpecific});

  @override
  $BenefitProviderCopyWith<$Res> get provider;
  @override
  $BenefitCopyWith<$Res> get benefit;
}

/// @nodoc
class __$$MatchedBenefitImplCopyWithImpl<$Res>
    extends _$MatchedBenefitCopyWithImpl<$Res, _$MatchedBenefitImpl>
    implements _$$MatchedBenefitImplCopyWith<$Res> {
  __$$MatchedBenefitImplCopyWithImpl(
      _$MatchedBenefitImpl _value, $Res Function(_$MatchedBenefitImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
    Object? benefit = null,
    Object? isMerchantSpecific = null,
  }) {
    return _then(_$MatchedBenefitImpl(
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as BenefitProvider,
      benefit: null == benefit
          ? _value.benefit
          : benefit // ignore: cast_nullable_to_non_nullable
              as Benefit,
      isMerchantSpecific: null == isMerchantSpecific
          ? _value.isMerchantSpecific
          : isMerchantSpecific // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchedBenefitImpl implements _MatchedBenefit {
  const _$MatchedBenefitImpl(
      {required this.provider,
      required this.benefit,
      this.isMerchantSpecific = false});

  factory _$MatchedBenefitImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchedBenefitImplFromJson(json);

  @override
  final BenefitProvider provider;
  @override
  final Benefit benefit;
  @override
  @JsonKey()
  final bool isMerchantSpecific;

  @override
  String toString() {
    return 'MatchedBenefit(provider: $provider, benefit: $benefit, isMerchantSpecific: $isMerchantSpecific)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchedBenefitImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.benefit, benefit) || other.benefit == benefit) &&
            (identical(other.isMerchantSpecific, isMerchantSpecific) ||
                other.isMerchantSpecific == isMerchantSpecific));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, provider, benefit, isMerchantSpecific);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchedBenefitImplCopyWith<_$MatchedBenefitImpl> get copyWith =>
      __$$MatchedBenefitImplCopyWithImpl<_$MatchedBenefitImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchedBenefitImplToJson(
      this,
    );
  }
}

abstract class _MatchedBenefit implements MatchedBenefit {
  const factory _MatchedBenefit(
      {required final BenefitProvider provider,
      required final Benefit benefit,
      final bool isMerchantSpecific}) = _$MatchedBenefitImpl;

  factory _MatchedBenefit.fromJson(Map<String, dynamic> json) =
      _$MatchedBenefitImpl.fromJson;

  @override
  BenefitProvider get provider;
  @override
  Benefit get benefit;
  @override
  bool get isMerchantSpecific;
  @override
  @JsonKey(ignore: true)
  _$$MatchedBenefitImplCopyWith<_$MatchedBenefitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
