import 'package:dio/dio.dart';

import 'app_exception.dart';

/// Runs an API call and normalizes any [DioException] into an [AppException].
/// All repository methods should funnel through this.
Future<T> guard<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    throw AppException.fromDio(e);
  } on AppException {
    rethrow;
  } catch (e) {
    throw AppException('Unexpected error: $e');
  }
}
