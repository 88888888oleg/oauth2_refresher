import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_payload.freezed.dart';
part 'token_payload.g.dart';

@freezed
class TokenPayload with _$TokenPayload {
  const factory TokenPayload({
    required String login,
    required String password,
  }) = _TokenPayload;
  const TokenPayload._();

  factory TokenPayload.fromJson(Map<String, dynamic> json) =>
      _$TokenPayloadFromJson(json);
}
