import 'package:firebase_auth/firebase_auth.dart';

import '../../constants/error_messages.dart';
import '../app_exception.dart';

class FirebaseAuthErrorMapper {
  const FirebaseAuthErrorMapper._();

  static AuthException map(FirebaseAuthException error) {
    switch (error.code) {
      case 'user-not-found':
        return const AuthException(AppErrorMessages.userNotFound);

      case 'wrong-password':
        return const AuthException(AppErrorMessages.wrongPassword);

      case 'email-already-in-use':
        return const AuthException(AppErrorMessages.emailAlreadyExists);

      case 'weak-password':
        return const AuthException(AppErrorMessages.weakPassword);

      case 'invalid-email':
        return const AuthException(AppErrorMessages.invalidEmail);

      case 'invalid-credential':
        return const AuthException(AppErrorMessages.invalidCredentials);

      case 'user-disabled':
        return const AuthException(AppErrorMessages.userDisabled);

      case 'operation-not-allowed':
        return const AuthException(AppErrorMessages.operationNotAllowed);

      case 'network-request-failed':
        return const AuthException(AppErrorMessages.noInternet);

      case 'too-many-requests':
        return const AuthException(AppErrorMessages.tooManyRequests);

      case 'invalid-phone-number':
        return const AuthException(AppErrorMessages.invalidPhoneNumber);

      case 'invalid-verification-code':
        return const AuthException(AppErrorMessages.invalidVerificationCode);

      case 'session-expired':
        return const AuthException(AppErrorMessages.sessionExpired);

      case 'quota-exceeded':
        return const AuthException(AppErrorMessages.quotaExceeded);

      case 'captcha-check-failed':
        return const AuthException(AppErrorMessages.captchaCheckFailed);

      case 'missing-phone-number':
        return const AuthException(AppErrorMessages.missingPhoneNumber);

      default:
        return AuthException(
          error.message ?? AppErrorMessages.authenticationError,
        );
    }
  }
}
