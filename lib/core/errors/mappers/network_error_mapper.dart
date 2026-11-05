import 'dart:async';
import 'dart:io';

import '../../constants/error_messages.dart';
import '../app_exception.dart';

class NetworkErrorMapper {
  const NetworkErrorMapper._();

  static NetworkException map(Object error) {
    if (error is SocketException) {
      return const NetworkException(AppErrorMessages.noInternet);
    }

    if (error is HandshakeException) {
      return const NetworkException(AppErrorMessages.secureConnectionFailed);
    }

    if (error is HttpException) {
      return const NetworkException(AppErrorMessages.httpError);
    }

    if (error is TimeoutException) {
      return const NetworkException(AppErrorMessages.requestTimeout);
    }

    return const NetworkException(AppErrorMessages.networkError);
  }
}
