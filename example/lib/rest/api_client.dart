import 'package:dio/dio.dart';
import 'package:oauth2_refresher/oauth2_refresher.dart';
import 'api_path.dart';
import 'auth_api/auth_api.dart';
import 'dio_error_handler.dart';

abstract class ApiClient {
  static Future<AuthApi> authApiClient([
    ResponseType? responseType,
  ]) async {
    return AuthApi(
      await _fetchDio(
        responseType,
      ),
    );
  }

  static Future<Dio> _fetchDio([
    ResponseType? responseType,
  ]) async {
    try {
      return Dio(
        await ApiPath.fetchOptions(
          responseType,
        ),
      );
    } on RevokeTokenException catch (dioError, s) {
      DioErrorHandler.handleDioError(
        DioException(
          requestOptions: RequestOptions(),
          message: 'RevokeTokenException',
          error: dioError,
        ),
        s,
      );
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
