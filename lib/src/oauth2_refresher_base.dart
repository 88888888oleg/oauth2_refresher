import 'dart:async';

import 'package:dio/dio.dart';
import 'package:oauth2_refresher/src/repositories/local/local_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// A singleton class for token refresh handling
class TokenHandler {
  static final TokenHandler _i = TokenHandler._();
  TokenHandler._() {
    _initializeTokenStream();
  }
  factory TokenHandler() => _i;

  /// The state of token refresh [OauthState]
  OauthState _oauthState = OauthState.active;

  /// Local repository for token storage
  final _localRepository = LocalRepository();

  /// A stream for token refresh events
  final StreamController<String> _tokenController =
      StreamController<String>.broadcast();

  /// Initializes the token stream
  Future<void> _initializeTokenStream() async {
    try {
      final token = await _localRepository.fetchAuthToken();
      _tokenController.sink.add(token);
    } catch (e) {
      _tokenController.sink.addError(e);
    }
  }

  Stream<String> get _tokenStream => _tokenController.stream;

  /// Saves tokens in the local repository, required during package initialization
  /// [authToken] - the authorization token
  /// [refreshToken] - the refresh token
  Future<bool> saveTokens({
    required String authToken,
    required String refreshToken,
  }) async {
    return await _localRepository.saveTokens(
      authToken: authToken,
      refreshToken: refreshToken,
    );
  }

  /// The main method for token refresh
  /// [refreshUrl] - the URL for refreshing the token
  /// [accessTokenName] - the key name for the access token
  /// [refreshTokenName] - the key name for the refresh token
  Future<String> fetchToken({
    required String refreshUrl,
    String accessTokenName = 'access_token',
    String refreshTokenName = 'refresh_token',
  }) async {
    await null;
    final token = await _localRepository.fetchAuthToken();
    if (token.isEmpty) {
      throw NotInitializedException();
    }
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

/// Exception for handling token refresh errors
class RevokeTokenException implements Exception {
  final String message;

  RevokeTokenException([this.message = "RevokeTokenException"]);

  /// Converts exception to string
  @override
  String toString() {
    return "RevokeTokenException: $message";
  }
}

/// States for token refresh
enum OauthState {
  active,
  pending,
}

/// Exception for handling cases when the token is not initialized
class NotInitializedException implements Exception {
  final String message;

  NotInitializedException(
      [this.message =
          "NotInitializedException. You need initialize tokens using saveTokens() method"]);

  /// Converts exception to string
  @override
  String toString() {
    return "NotInitializedException: $message";
  }
}
