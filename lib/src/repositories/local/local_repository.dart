import 'package:oauth2_refresher/oauth2_refresher.dart';
import 'package:hive/hive.dart';

/// Local token storage, singleton
class LocalRepository implements ILocalRepository {
  LocalRepository._();
  static final LocalRepository _instance = LocalRepository._();
  factory LocalRepository() => _instance;

  Box<String>? _hiveBox;

  /// For faster access to the Hive box
  Future<Box<String>> get _boxInstance async {
    _hiveBox ??= await Hive.openBox<String>('auth_tokens');
    return _hiveBox!;
  }

  /// Deletes the authorization token
  @override
  Future<void> deleteAuthToken() async {
    final box = await _boxInstance;
    await box.delete('authToken');
  }

  /// Saves the authorization token
  /// [authToken] - the authorization token
  @override
  Future<bool> saveAuthToken({required String authToken}) async {
    final box = await _boxInstance;
    await box.put('authToken', authToken);
    return true;
  }

  /// Retrieves the authorization token
  @override
  Future<String> fetchAuthToken() async {
    final box = await _boxInstance;
    return box.get('authToken', defaultValue: '') ?? '';
  }

  /// Deletes the refresh token
  @override
  Future<void> deleteRefreshToken() async {
    final box = await _boxInstance;
    await box.delete('refreshToken');
  }

  /// Saves the refresh token
  /// [refreshToken] - the refresh token
  @override
  Future<bool> saveRefreshToken({required String refreshToken}) async {
    final box = await _boxInstance;
    await box.put('refreshToken', refreshToken);
    return true;
  }

  /// Retrieves the refresh token
  @override
  Future<String> fetchRefreshToken() async {
    final box = await _boxInstance;
    return box.get('refreshToken', defaultValue: '') ?? '';
  }

  /// Clears both tokens
  /// Deletes the authorization and refresh tokens
  @override
  Future<void> clearTokens() async {
    await deleteAuthToken();
    await deleteRefreshToken();
  }

  /// Saves both tokens
  /// [refreshToken] - the refresh token
  /// [authToken] - the authorization token
  @override
  Future<bool> saveTokens({
    required String refreshToken,
    required String authToken,
  }) async {
    final authResult = await saveAuthToken(authToken: authToken);
    final refreshResult = await saveRefreshToken(refreshToken: refreshToken);
    return authResult && refreshResult;
  }
}