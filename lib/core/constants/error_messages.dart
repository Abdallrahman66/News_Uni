abstract final class AppErrorMessages {
  const AppErrorMessages._();

  // Network
  static const noInternet = "No Internet Connection";
  static const networkError = "Network Error";
  static const requestTimeout = "Request timeout";
  static const httpError = "HTTP Error";
  static const secureConnectionFailed = "Secure connection failed";

  // REST / API (Dio)
  static const badRequest = "Invalid request";
  static const unauthorized = "You are not authorized. Please log in again.";
  static const forbidden = "You don't have permission to do this";
  static const notFound = "Requested resource not found";
  static const conflict = "This request conflicts with existing data";
  static const unprocessableEntity = "The submitted data is invalid";
  static const requestCancelled = "Request was cancelled";

  // Authentication
  static const userNotFound = "User not found";
  static const wrongPassword = "Wrong password";
  static const emailAlreadyExists = "Email already exists";
  static const weakPassword = "Weak password";
  static const invalidEmail = "Invalid email address";
  static const invalidCredentials = "Invalid credentials";
  static const userDisabled = "This account has been disabled";
  static const operationNotAllowed = "Operation not allowed";
  static const tooManyRequests = "Too many requests. Please try again later.";
  static const authenticationError = "Authentication Error";

  // Firestore / Database
  static const permissionDenied = "Permission denied";
  static const documentNotFound = "Document not found";
  static const documentAlreadyExists = "Document already exists";
  static const operationCancelled = "Operation cancelled";
  static const dataLoss = "Data loss";
  static const failedPrecondition = "Failed precondition";
  static const internalServerError = "Internal server error";
  static const invalidArgument = "Invalid argument";
  static const outOfRange = "Value out of range";
  static const resourceExhausted = "Resource exhausted";
  static const unauthenticated = "Unauthenticated";
  static const serviceUnavailable = "Service unavailable";
  static const featureNotImplemented = "Feature not implemented";
  static const databaseError = "Database Error";
  static const String invalidPhoneNumber = 'The phone number is invalid.';

  static const String invalidVerificationCode =
      'The verification code is invalid.';

  static const String sessionExpired =
      'The verification session has expired. Please request a new code.';

  static const String quotaExceeded =
      'SMS quota exceeded. Please try again later.';

  static const String captchaCheckFailed =
      'reCAPTCHA verification failed. Please try again.';

  static const String missingPhoneNumber = 'Phone number is required.';

  // Server
  static const serverError = "Server Error";
  static const invalidData = "Invalid data format";

  // Platform
  static const platformError = "Platform Error";

  // Cache
  static const cacheError = "Cache Error";

  // Unknown
  static const unknown = "An unknown error occurred";
}
