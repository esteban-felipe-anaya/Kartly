import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../env/env.dart';
import 'interceptors.dart';

/// Builds the configured [Dio] instance used by all API clients.
Dio createDio({required String? Function() tokenReader}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(tokenReader),
    LatencyErrorInterceptor(enabled: Env.simulateNetworkConditions),
    PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseBody: false,
      compact: true,
      maxWidth: 100,
    ),
  ]);

  return dio;
}
