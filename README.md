# Flutter OAuth2 Token Refresh Handler

A lightweight package for seamless token refresh in OAuth 2.0. You only need to supply your tokens after the user is authorized and implement a simple method where you construct your request headers. Everything else is done automatically. This package supports parallel requests and serves as an alternative to standard interceptors. For example, if you send 5 requests simultaneously and the token has already expired, the package will refresh the token first, and only then will all the requests be processed in parallel. During the token refresh request, new requests might come in — they will be added to the queue, and once a fresh token is obtained, all the requests will be handled simultaneously.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
    - [1. Save Tokens](#1-save-tokens)
    - [2. Fetch and Use Tokens](#2-fetch-and-use-tokens)
    - [3. Always Use a New API Instance](#3-always-use-a-new-api-instance)
- [Parallel Request Handling](#parallel-request-handling)
- [Token Expiration](#token-expiration)
- [Custom Token Fields](#custom-token-fields)
- [Example](#example)
- [License](#license)

---

## Features

- **Easy Integration**: Just provide your tokens and let the package handle token refresh automatically.
- **Parallel Requests**: When multiple parallel requests detect an expired token, the package refreshes the token only once for the first request. The other requests wait in a queue and then proceed with the fresh token.
- **Interceptor Alternative**: Works as a straightforward replacement for complex interceptors.
- **Similar to Cognito**: Requires a fresh API client whenever you make requests, similar to AWS Cognito usage patterns.

---

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  oauth2_refresher: ^1.0.0
```

Then run:

```sh
flutter pub get
```

### 1. Provide Tokens After Authentication
After the user has successfully authenticated, supply the 'accessToken and 'refreshToken' to the package:
```dart
await TokenHandler().saveTokens(
authToken: right.accessToken,
refreshToken: right.refreshToken,
);
```
### 2. Fetch and Use Tokens in Headers
Request the token from the package wherever the headers are being set. Provide the 'refreshUrl' to handle token refresh automatically:
```dart
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
```
### 3. Always use a new instance of Dio
Since the handler collects instances into a stream for efficient parallel request handling, you need to use a new Dio instance for each request (this will not affect performance):
```dart
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
```


### 4. Token Expiration
If the refresh token has expired, the package will throw an exception:
```dart
RevokeTokenException ();
```
This can be caught in your code to prompt the user to reauthenticate or take appropriate action.
### 5. Custom Token Fields
By default, the package expects the tokens to be provided in the following JSON fields:
```text
'access_token'
'refresh_token'
```
You can customize these field names if your server uses different ones.
### Example
For a complete demonstration, check out the example file included in the repository.
