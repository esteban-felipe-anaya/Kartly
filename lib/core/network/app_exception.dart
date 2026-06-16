import 'package:dio/dio.dart';

/// Typed application error surfaced to the UI. Repositories convert raw
/// [DioException]s into these so widgets never deal with transport details.
enum AppErrorType { network, timeout, unauthorized, notFound, server, unknown }

class AppException implements Exception {
  const AppException(this.message, {this.type = AppErrorType.unknown, this.statusCode});

  final String message;
  final AppErrorType type;
  final int? statusCode;

  factory AppException.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppException(
          'The connection timed out. Please try again.',
          type: AppErrorType.timeout,
        );
      case DioExceptionType.connectionError:
        return const AppException(
          'Could not reach the server. Check your connection and that the '
          'mock API is running.',
          type: AppErrorType.network,
        );
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        final serverMsg = _extractMessage(e.response?.data);
        if (code == 401 || code == 403) {
          return AppException(
            serverMsg ?? 'You need to sign in to continue.',
            type: AppErrorType.unauthorized,
            statusCode: code,
          );
        }
        if (code == 404) {
          return AppException(
            serverMsg ?? 'We couldn\'t find what you were looking for.',
            type: AppErrorType.notFound,
            statusCode: code,
          );
        }
        return AppException(
          serverMsg ?? 'Something went wrong on the server.',
          type: AppErrorType.server,
          statusCode: code,
        );
      default:
        return AppException(
          e.message ?? 'An unexpected error occurred.',
          type: AppErrorType.unknown,
        );
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map && data['message'] is String) return data['message'] as String;
    return null;
  }

  @override
  String toString() => message;
}
