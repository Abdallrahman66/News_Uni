import 'enums/error_codes.dart';

/// ---------------------------------------------------------------------------
/// App Exception System
/// ---------------------------------------------------------------------------
///
/// A unified exception system used across the entire application.
///
/// ## Why does this exist?
///
/// External libraries throw different types of exceptions.
///
/// Examples:
/// - FirebaseAuthException
/// - FirebaseException
/// - DioException
/// - SocketException
/// - TimeoutException
///
/// If these exceptions are used directly inside the UI or Business Logic,
/// the project becomes tightly coupled to those libraries.
///
/// Instead, every external exception is mapped into an [AppException].
///
/// Example:
///
/// FirebaseAuthException
///          ↓
/// FirebaseAuthErrorMapper
///          ↓
/// AuthException
///          ↓
/// Repository
///          ↓
/// ResultNetwork.error(...)
///          ↓
/// Cubit
///          ↓
/// RegisterFailureState
///          ↓
/// UI
///
/// ---------------------------------------------------------------------------
///
/// Every exception contains two important properties:
///
/// message
/// --------
/// A human-readable message.
///
/// This is the text displayed to the user.
///
/// Example:
///
/// "Wrong email or password"
///
/// "No Internet Connection"
///
/// "Something went wrong"
///
/// Usage:
///
/// AppToast.show(
///   description: state.error.message,
/// );
///
/// ---------------------------------------------------------------------------
///
/// code
/// ----
/// Represents the category of the error.
///
/// It is NOT displayed to the user.
///
/// Instead, it allows the application to decide how to react.
///
/// Example:
///
/// ErrorCode.network
///
/// → Show Retry Dialog.
///
/// ErrorCode.auth
///
/// → Show Authentication Error.
///
/// ErrorCode.server
///
/// → Show Maintenance Screen.
///
/// ErrorCode.validation
///
/// → Highlight invalid form fields.
///
/// ---------------------------------------------------------------------------
///
/// Typical Error Flow
///
/// Firebase
///      ↓
/// FirebaseAuthException
///      ↓
/// FirebaseAuthErrorMapper
///      ↓
/// AuthException
///      ↓
/// Repository
///      ↓
/// ErrorNetwork<AuthException>
///      ↓
/// Cubit
///      ↓
/// RegisterFailureState(error)
///      ↓
/// BlocConsumer.listener
///      ↓
/// AppToast.show(error.message)
///
/// ---------------------------------------------------------------------------
///
/// Example
///
/// throw AuthException(
///   "Wrong email or password",
/// );
///
/// Repository
///
/// return ErrorNetwork(exception);
///
/// Cubit
///
/// emit(
///   RegisterFailureState(exception),
/// );
///
/// UI
///
/// AppToast.show(
///   description: state.error.message,
/// );
///
/// ---------------------------------------------------------------------------
///
/// When should I use `message`?
///
/// Whenever the user needs to read the error.
///
/// Examples:
///
/// • Toast
/// • SnackBar
/// • Dialog
/// • Error Text
///
/// Example:
///
/// AppToast.show(
///   description: state.error.message,
/// );
///
/// ---------------------------------------------------------------------------
///
/// When should I use `code`?
///
/// Whenever the application behavior changes depending on the error type.
///
/// Example:
///
/// switch(state.error.code){
///
///   case ErrorCode.network:
///      // Show Retry Dialog
///      break;
///
///   case ErrorCode.auth:
///      // Logout or Authentication Error
///      break;
///
///   case ErrorCode.server:
///      // Show Maintenance Screen
///      break;
///
///   default:
///      // Generic Error
/// }
///
/// ---------------------------------------------------------------------------
///
/// Why not compare messages?
///
/// ❌ Bad
///
/// if(error.message == "No Internet"){
///    ...
/// }
///
/// Messages may change because of:
///
/// • Localization
/// • Copy updates
/// • API changes
///
/// Instead:
///
/// ✔ Good
///
/// if(error.code == ErrorCode.network){
///    ...
/// }
///
/// ---------------------------------------------------------------------------
///
/// Benefits
///
/// ✔ Decouples the application from external libraries.
///
/// ✔ One exception model for the entire application.
///
/// ✔ Makes UI independent from Firebase or Dio.
///
/// ✔ Easier testing.
///
/// ✔ Easier maintenance.
///
/// ✔ Easy to add new data sources in the future.
///
/// ✔ Consistent error handling across all features.
/// 
/// 
/// 



//!--------------------------------------------------------------------------------------------------



sealed class AppException implements Exception {
  const AppException({required this.message, required this.code});

  final String message;
  final ErrorCode code;

  @override
  String toString() => message;
}

/// ===============================
/// Network Exceptions
/// ===============================

class NetworkException extends AppException {
  const NetworkException(String message)
    : super(message: message, code: ErrorCode.network);
}

class RequestTimeoutException extends AppException {
  const RequestTimeoutException(String message)
    : super(message: message, code: ErrorCode.timeout);
}

/// ===============================
/// Authentication Exceptions
/// ===============================

class AuthException extends AppException {
  const AuthException(String message)
    : super(message: message, code: ErrorCode.auth);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(String message)
    : super(message: message, code: ErrorCode.auth);
}

/// ===============================
/// Database Exceptions
/// ===============================

class DatabaseException extends AppException {
  const DatabaseException(String message)
    : super(message: message, code: ErrorCode.database);
}

/// ===============================
/// Server Exceptions
/// ===============================

class ServerException extends AppException {
  const ServerException(String message)
    : super(message: message, code: ErrorCode.server);
}

/// ===============================
/// Cache Exceptions
/// ===============================

class CacheException extends AppException {
  const CacheException(String message)
    : super(message: message, code: ErrorCode.cache);
}

/// ===============================
/// Validation Exceptions
/// ===============================

class ValidationException extends AppException {
  const ValidationException(String message)
    : super(message: message, code: ErrorCode.validation);
}

/// ===============================
/// Unknown Exceptions
/// ===============================

class UnknownException extends AppException {
  const UnknownException(String message)
    : super(message: message, code: ErrorCode.unknown);
}
