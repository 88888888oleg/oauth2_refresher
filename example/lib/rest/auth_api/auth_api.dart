import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/token_payload.dart';
import '../../models/token_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST('/auth/token/')
  Future<TokenResponse> fetchToken(
    @Body() TokenPayload data,
  );

  @GET('/example/')
  Future<void> example();
}
