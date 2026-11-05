import 'package:dio/dio.dart';

import '../../constants/error_messages.dart';
import '../app_exception.dart';

/// Maps a [DioException] thrown by the Dio HTTP client into a specific
/// [AppException] subtype with a clear, user-facing message.
///
/// Dio wraps every failure - connection issues, timeouts, cancellations,
/// bad SSL certificates, and non-2xx HTTP responses - inside a single
/// [DioException]. Exposing that type directly to the Repository/Cubit
/// layers would mean every caller needs to know Dio's internals.
///
/// This mapper inspects [DioException.type] and, for
/// [DioExceptionType.badResponse], the HTTP status code, to decide which
/// [AppException] subtype best represents the failure.
class DioErrorMapper {
  const DioErrorMapper._();

  static AppException map(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const RequestTimeoutException(AppErrorMessages.requestTimeout);

      case DioExceptionType.connectionError:
        return const NetworkException(AppErrorMessages.noInternet);

      case DioExceptionType.badCertificate:
        return const NetworkException(AppErrorMessages.secureConnectionFailed);

      case DioExceptionType.cancel:
        return const ServerException(AppErrorMessages.requestCancelled);

      case DioExceptionType.badResponse:
        return _mapStatusCode(error);

      case DioExceptionType.unknown:
        return ServerException(error.message ?? AppErrorMessages.unknown);
    }
  }

  /// Maps an HTTP status code (from a [DioExceptionType.badResponse]) to
  /// the [AppException] subtype that best represents it.
  static AppException _mapStatusCode(DioException error) {
    final statusCode = error.response?.statusCode;

    switch (statusCode) {
      case 400:
        return const ServerException(AppErrorMessages.badRequest);

      case 401:
        return const UnauthorizedException(AppErrorMessages.unauthorized);

      case 403:
        return const UnauthorizedException(AppErrorMessages.forbidden);

      case 404:
        return const ServerException(AppErrorMessages.notFound);

      case 408:
        return const RequestTimeoutException(AppErrorMessages.requestTimeout);

      case 409:
        return const ServerException(AppErrorMessages.conflict);

      case 422:
        return const ValidationException(AppErrorMessages.unprocessableEntity);

      case 429:
        return const ServerException(AppErrorMessages.tooManyRequests);

      case 500:
      case 502:
      case 503:
        return const ServerException(AppErrorMessages.internalServerError);

      default:
        return ServerException(
          error.response?.statusMessage ?? AppErrorMessages.serverError,
        );
    }
  }
}
