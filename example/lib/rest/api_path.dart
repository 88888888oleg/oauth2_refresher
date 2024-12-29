import 'package:dio/dio.dart';
import 'package:oauth2_refresher/oauth2_refresher.dart';

abstract class ApiPath {
  static String baseUrl() => 'https://www.example.com';

  static Future<Map<String, String>> fetchHeaders([
    ResponseType? responseType,
  ]) async {
    final idToken = await TokenHandler().fetchToken(refreshUrl: baseUrl());
    switch (responseType) {
      case ResponseType.bytes:
        return {
          'Accept': 'application/octet-stream',
          'Content-Type': 'application/octet-stream',
          'Authorization': 'Bearer $idToken',
        };
      default:
        return {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
        };
    }
  }

  static Future<BaseOptions> fetchOptions([
    ResponseType? responseType,
  ]) async {
    return BaseOptions(
      baseUrl: ApiPath.baseUrl(),
      headers: await fetchHeaders(responseType),
      responseType: responseType ?? ResponseType.json,
    );
  }
}

