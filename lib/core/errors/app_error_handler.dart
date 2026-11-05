import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../constants/error_messages.dart';
import 'app_exception.dart';
import 'mappers/dio_error_mapper.dart';
import 'mappers/firebase_auth_error_mapper.dart';
import 'mappers/firestore_error_mapper.dart';
import 'mappers/network_error_mapper.dart';

class ErrorHandler {
  const ErrorHandler._();

  static Never handle(Object error) {
    if (error is AppException) {
      throw error;
    }

    if (error is DioException) {
      throw DioErrorMapper.map(error);
    }

    if (error is SocketException ||
        error is HandshakeException ||
        error is HttpException ||
        error is TimeoutException) {
      throw NetworkErrorMapper.map(error);
    }

    if (error is FirebaseAuthException) {
      throw FirebaseAuthErrorMapper.map(error);
    }

    if (error is FirebaseException) {
      throw FirestoreErrorMapper.map(error);
    }

    if (error is FormatException) {
      throw const ServerException(AppErrorMessages.invalidData);
    }

    if (error is PlatformException) {
      throw UnknownException(error.message ?? AppErrorMessages.platformError);
    }

    throw const UnknownException(AppErrorMessages.unknown);
  }
}
