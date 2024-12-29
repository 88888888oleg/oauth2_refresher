import 'dart:async';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import '../models/token_payload.dart';
import '../models/token_response.dart';
import '../rest/api_client.dart';
import '../rest/dio_error_handler.dart';

abstract class AuthRepository {
  static Future<Either<String, TokenResponse>> logIn({
    required String login,
    required String password,
  }) async {
    try {
      final tokenResponse = await (await ApiClient.authApiClient())
          .fetchToken(TokenPayload(login: login, password: password));
      return Right(tokenResponse);
    } on DioException catch (dioError, s) {
      return Left(DioErrorHandler.handleDioError(dioError, s));
    } catch (e) {
      return Left(e.toString());
    }
  }

  static Future<Either<String, void>> example() async {
    try {
      await (await ApiClient.authApiClient()).example();
      return Right(null);
    } on DioException catch (dioError, s) {
      return Left(DioErrorHandler.handleDioError(dioError, s));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
