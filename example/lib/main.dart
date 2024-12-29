import 'package:oauth2_refresher/oauth2_refresher.dart';
import 'dart:async';

import 'repository/auth_repository.dart';


Future<void> main() async {
  /// Log in user
  final res = await AuthRepository.logIn(
    login: 'login',
    password: 'password',
  );
  await res.fold((left) async {
    /// Do something with error
  }, (right) async {
    /// add tokens to the handler
    await TokenHandler().saveTokens(
      authToken: right.accessToken,
      refreshToken: right.refreshToken,
    );
  });

  /// and use multiple jre single requests
  final results = await Future.wait([
    AuthRepository.example(),
    AuthRepository.example(),
    AuthRepository.example(),
  ]);

  for (var i = 0; i < results.length; i++) {
    results[i].fold(
          (error) => print('Request ${i + 1} failed: $error'),
          (_) => print('Request ${i + 1} succeeded'),
    );
  }
}
