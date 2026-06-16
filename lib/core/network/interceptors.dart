import 'dart:math';

import 'package:dio/dio.dart';

/// Attaches the bearer token (when present) to every outgoing request.
///
/// The token is read lazily through [tokenReader] so it always reflects the
/// latest authenticated session without rebuilding the Dio client.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.tokenReader);

  final String? Function() tokenReader;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = tokenReader();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

/// Development-only interceptor that makes the mock API feel like a real one by
/// injecting 300–800ms of latency and occasional transient failures. This
/// guarantees loading and error states are actually exercised.
class LatencyErrorInterceptor extends Interceptor {
  LatencyErrorInterceptor({
    this.enabled = true,
    this.errorProbability = 0.08,
    Random? random,
  }) : _random = random ?? Random();

  final bool enabled;
  final double errorProbability;
  final Random _random;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!enabled) return handler.next(options);

    final delayMs = 300 + _random.nextInt(500);
    await Future<void>.delayed(Duration(milliseconds: delayMs));

    // Never fail auth or order placement — those flows must stay deterministic
    // for a smooth demo. Inject flaky failures only on idempotent reads.
    final isSafeToFail = options.method == 'GET' &&
        !options.path.contains('/auth') &&
        !options.path.contains('/orders');
    if (isSafeToFail && _random.nextDouble() < errorProbability) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'Simulated transient network error',
        ),
      );
    }
    handler.next(options);
  }
}
