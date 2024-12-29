import 'dart:async';

import 'package:dio/dio.dart';
import 'package:oauth2_refresher/src/repositories/local/local_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

const tokenType = 'Bearer';

class TokenHandler {
  static final TokenHandler _i = TokenHandler._();
  TokenHandler._() {
    _initializeTokenStream();
  }
  factory TokenHandler() => _i;

  OauthState _oauthState = OauthState.active;
  final _localRepository = LocalRepository();

  final StreamController<String> _tokenController =
      StreamController<String>.broadcast();

  Future<void> _initializeTokenStream() async {
    try {
      final token = await _localRepository.fetchAuthToken();
      _tokenController.sink.add(token);
    } catch (e) {
      _tokenController.sink.addError(e);
    }
  }

  Stream<String> get _tokenStream => _tokenController.stream;

  Future<bool> saveTokens({
    required String authToken,
    required String refreshToken,
  }) async {
    return await _localRepository.saveTokens(
      authToken: authToken,
      refreshToken: refreshToken,
    );
  }

  Future<String> fetchToken({
    required String refreshUrl,
    String accessTokenName = 'access_token',
    String refreshTokenName = 'refresh_token',
  }) async {
    await null;
    final token = await _localRepository.fetchAuthToken();
    var hasExpired = token.isNotEmpty ? JwtDecoder.isExpired(token) : false;
    if (!hasExpired) {
      return token;
    }

    switch (_oauthState) {
      case OauthState.pending:
        return await _tokenStream.firstWhere((token) => token.isNotEmpty);
      case OauthState.active:
        _oauthState = OauthState.pending;
        final refreshToken = await _localRepository.fetchRefreshToken();
        try {
          final response = await Dio().post(
            refreshUrl,
            data: {
              refreshTokenName: refreshToken,
            },
          );
          final newAccessToken = response.data[accessTokenName];
          final newRefreshToken = response.data[refreshTokenName];

          await saveTokens(
            refreshToken: newRefreshToken,
            authToken: newAccessToken,
          );
          _tokenController.sink.add(newAccessToken);
          _oauthState = OauthState.active;
          return newAccessToken;
        } catch (e) {
          throw RevokeTokenException(e.toString());
        }
    }
  }
}

class RevokeTokenException implements Exception {
  final String message;

  RevokeTokenException([this.message = "RevokeTokenException"]);

  @override
  String toString() {
    return "RevokeTokenException: $message";
  }
}

enum OauthState {
  active,
  pending,
}
