/// Interface for local repository
abstract interface class ILocalRepository {
  Future<void> deleteAuthToken();
  Future<bool> saveAuthToken({required String authToken});
  Future<String> fetchAuthToken();
  Future<void> deleteRefreshToken();
  Future<bool> saveRefreshToken({required String refreshToken});
  Future<String> fetchRefreshToken();
  Future<void> clearTokens();
  Future<bool> saveTokens({required String refreshToken, required String authToken});
}
