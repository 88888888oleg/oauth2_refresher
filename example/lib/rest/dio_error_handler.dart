
import 'package:dio/dio.dart';

abstract final class DioErrorHandler {
  static String handleDioError(
    DioException dioError,
    StackTrace s, [
    bool? isCheckRejectedNeeds,
  ]) {
    if (dioError.toString().contains('RevokeTokenException')) {
      /// You can change AuthenticationStatus here
      // rootBloc.add(
      //   const RootEvent.authenticationStatusChanged(
      //     status: UserAuthenticationStatus.signedOut,
      //   ),
      // );
      return '';
    } else if (dioError.response != null) {
      try {
        final errorMessage =
            dioError.response?.data['errors']?.first ?? 'Something went wrong.';
        return errorMessage;
      } catch (e) {
        return 'Something went wrong.';
      }
    } else {
      return 'Something went wrong.';
    }
  }
}
