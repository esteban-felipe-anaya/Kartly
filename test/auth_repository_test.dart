import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartly/core/network/app_exception.dart';
import 'package:kartly/data/api/kartly_api.dart';
import 'package:kartly/data/repositories/auth_repository.dart';

/// A canned Dio transport adapter: returns a fixed status + JSON body for any
/// request, letting us exercise the real Dio + Retrofit pipeline without a
/// live server.
class _CannedAdapter implements HttpClientAdapter {
  _CannedAdapter(this.statusCode, this.body);

  final int statusCode;
  final Object body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

AuthRepository _repoReturning(int status, Object body) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local'))
    ..httpClientAdapter = _CannedAdapter(status, body);
  return AuthRepository(KartlyApi(dio));
}

void main() {
  group('AuthRepository (mocked Dio)', () {
    test('login parses token and user on 200', () async {
      final repo = _repoReturning(200, {
        'token': 'mock-token',
        'user': {
          'id': 'usr_1',
          'name': 'Jamie Rivera',
          'email': 'demo@kartly.app',
          'avatar': null,
        },
      });

      final res = await repo.login('demo@kartly.app', 'password123');
      expect(res.token, 'mock-token');
      expect(res.user.id, 'usr_1');
      expect(res.user.email, 'demo@kartly.app');
    });

    test('maps a 401 response to an unauthorized AppException', () async {
      final repo = _repoReturning(401, {'message': 'Invalid email or password'});

      expect(
        () => repo.login('demo@kartly.app', 'wrong'),
        throwsA(
          isA<AppException>()
              .having((e) => e.type, 'type', AppErrorType.unauthorized)
              .having((e) => e.statusCode, 'statusCode', 401),
        ),
      );
    });
  });
}
