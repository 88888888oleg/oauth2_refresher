// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TokenPayload _$TokenPayloadFromJson(Map<String, dynamic> json) {
  return _TokenPayload.fromJson(json);
}

/// @nodoc
mixin _$TokenPayload {
  String get login => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this TokenPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenPayloadCopyWith<TokenPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenPayloadCopyWith<$Res> {
  factory $TokenPayloadCopyWith(
          TokenPayload value, $Res Function(TokenPayload) then) =
      _$TokenPayloadCopyWithImpl<$Res, TokenPayload>;
  @useResult
  $Res call({String login, String password});
}

/// @nodoc
class _$TokenPayloadCopyWithImpl<$Res, $Val extends TokenPayload>
    implements $TokenPayloadCopyWith<$Res> {
  _$TokenPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenPayloadImplCopyWith<$Res>
    implements $TokenPayloadCopyWith<$Res> {
  factory _$$TokenPayloadImplCopyWith(
          _$TokenPayloadImpl value, $Res Function(_$TokenPayloadImpl) then) =
      __$$TokenPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String login, String password});
}

/// @nodoc
class __$$TokenPayloadImplCopyWithImpl<$Res>
    extends _$TokenPayloadCopyWithImpl<$Res, _$TokenPayloadImpl>
    implements _$$TokenPayloadImplCopyWith<$Res> {
  __$$TokenPayloadImplCopyWithImpl(
      _$TokenPayloadImpl _value, $Res Function(_$TokenPayloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = null,
    Object? password = null,
  }) {
    return _then(_$TokenPayloadImpl(
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenPayloadImpl extends _TokenPayload {
  const _$TokenPayloadImpl({required this.login, required this.password})
      : super._();

  factory _$TokenPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenPayloadImplFromJson(json);

  @override
  final String login;
  @override
  final String password;

  @override
  String toString() {
    return 'TokenPayload(login: $login, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenPayloadImpl &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, login, password);

  /// Create a copy of TokenPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenPayloadImplCopyWith<_$TokenPayloadImpl> get copyWith =>
      __$$TokenPayloadImplCopyWithImpl<_$TokenPayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenPayloadImplToJson(
      this,
    );
  }
}

abstract class _TokenPayload extends TokenPayload {
  const factory _TokenPayload(
      {required final String login,
      required final String password}) = _$TokenPayloadImpl;
  const _TokenPayload._() : super._();

  factory _TokenPayload.fromJson(Map<String, dynamic> json) =
      _$TokenPayloadImpl.fromJson;

  @override
  String get login;
  @override
  String get password;

  /// Create a copy of TokenPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenPayloadImplCopyWith<_$TokenPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
