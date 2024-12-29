import 'package:oauth2_refresher/oauth2_refresher.dart';

class LocalRepository implements ILocalRepository {
  LocalRepository._();
  static final LocalRepository _instance = LocalRepository._();
  factory LocalRepository() => _instance;

  SharedPreferences? _prefs;

  Future<SharedPreferences> get _prefsInstance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<void> deleteAuthToken() async {
    final prefs = await _prefsInstance;
    await prefs.remove('authToken');
  }

  @override
  Future<bool> saveAuthToken({required String authToken}) async {
    final prefs = await _prefsInstance;
    return prefs.setString('authToken', authToken);
  }

  @override
  Future<String> fetchAuthToken() async {
    final prefs = await _prefsInstance;
    return prefs.getString('authToken') ?? '';
  }

  @override
  Future<void> deleteRefreshToken() async {
    final prefs = await _prefsInstance;
    await prefs.remove('refreshToken');
  }

  @override
  Future<bool> saveRefreshToken({required String refreshToken}) async {
    final prefs = await _prefsInstance;
    return prefs.setString('refreshToken', refreshToken);
  }

  @override
  Future<String> fetchRefreshToken() async {
    final prefs = await _prefsInstance;
    return prefs.getString('refreshToken') ?? '';
  }

  @override
  Future<void> clearTokens() async {
    await deleteAuthToken();
    await deleteRefreshToken();
  }

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
