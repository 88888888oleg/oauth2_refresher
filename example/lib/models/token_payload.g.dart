// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenPayloadImpl _$$TokenPayloadImplFromJson(Map<String, dynamic> json) =>
    _$TokenPayloadImpl(
      login: json['login'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$TokenPayloadImplToJson(_$TokenPayloadImpl instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
    };
