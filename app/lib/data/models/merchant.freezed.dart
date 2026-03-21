// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merchant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Merchant _$MerchantFromJson(Map<String, dynamic> json) {
  return _Merchant.fromJson(json);
}

/// @nodoc
mixin _$Merchant {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  List<String> get aliases => throw _privateConstructorUsedError;
  bool get isFranchise => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MerchantCopyWith<Merchant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MerchantCopyWith<$Res> {
  factory $MerchantCopyWith(Merchant value, $Res Function(Merchant) then) =
      _$MerchantCopyWithImpl<$Res, Merchant>;
  @useResult
  $Res call(
      {String id,
      String name,
      String categoryId,
      List<String> aliases,
      bool isFranchise,
      int sortOrder,
      bool isActive});
}

/// @nodoc
class _$MerchantCopyWithImpl<$Res, $Val extends Merchant>
    implements $MerchantCopyWith<$Res> {
  _$MerchantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? categoryId = null,
    Object? aliases = null,
    Object? isFranchise = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      aliases: null == aliases
          ? _value.aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isFranchise: null == isFranchise
          ? _value.isFranchise
          : isFranchise // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MerchantImplCopyWith<$Res>
    implements $MerchantCopyWith<$Res> {
  factory _$$MerchantImplCopyWith(
          _$MerchantImpl value, $Res Function(_$MerchantImpl) then) =
      __$$MerchantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String categoryId,
      List<String> aliases,
      bool isFranchise,
      int sortOrder,
      bool isActive});
}

/// @nodoc
class __$$MerchantImplCopyWithImpl<$Res>
    extends _$MerchantCopyWithImpl<$Res, _$MerchantImpl>
    implements _$$MerchantImplCopyWith<$Res> {
  __$$MerchantImplCopyWithImpl(
      _$MerchantImpl _value, $Res Function(_$MerchantImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? categoryId = null,
    Object? aliases = null,
    Object? isFranchise = null,
    Object? sortOrder = null,
    Object? isActive = null,
  }) {
    return _then(_$MerchantImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      aliases: null == aliases
          ? _value._aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isFranchise: null == isFranchise
          ? _value.isFranchise
          : isFranchise // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MerchantImpl implements _Merchant {
  const _$MerchantImpl(
      {required this.id,
      required this.name,
      required this.categoryId,
      final List<String> aliases = const [],
      this.isFranchise = true,
      this.sortOrder = 0,
      this.isActive = true})
      : _aliases = aliases;

  factory _$MerchantImpl.fromJson(Map<String, dynamic> json) =>
      _$$MerchantImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String categoryId;
  final List<String> _aliases;
  @override
  @JsonKey()
  List<String> get aliases {
    if (_aliases is EqualUnmodifiableListView) return _aliases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_aliases);
  }

  @override
  @JsonKey()
  final bool isFranchise;
  @override
  @JsonKey()
  final int sortOrder;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'Merchant(id: $id, name: $name, categoryId: $categoryId, aliases: $aliases, isFranchise: $isFranchise, sortOrder: $sortOrder, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MerchantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            const DeepCollectionEquality().equals(other._aliases, _aliases) &&
            (identical(other.isFranchise, isFranchise) ||
                other.isFranchise == isFranchise) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      categoryId,
      const DeepCollectionEquality().hash(_aliases),
      isFranchise,
      sortOrder,
      isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MerchantImplCopyWith<_$MerchantImpl> get copyWith =>
      __$$MerchantImplCopyWithImpl<_$MerchantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MerchantImplToJson(
      this,
    );
  }
}

abstract class _Merchant implements Merchant {
  const factory _Merchant(
      {required final String id,
      required final String name,
      required final String categoryId,
      final List<String> aliases,
      final bool isFranchise,
      final int sortOrder,
      final bool isActive}) = _$MerchantImpl;

  factory _Merchant.fromJson(Map<String, dynamic> json) =
      _$MerchantImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get categoryId;
  @override
  List<String> get aliases;
  @override
  bool get isFranchise;
  @override
  int get sortOrder;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$MerchantImplCopyWith<_$MerchantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
