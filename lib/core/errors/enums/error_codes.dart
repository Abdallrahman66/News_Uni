// ignore: dangling_library_doc_comments
///══════════════════════════════════════════════════════════════════════════════
/// Why do we need ErrorCode?
///══════════════════════════════════════════════════════════════════════════════
///
/// ## The Problem
///
/// During application execution, errors can originate from many different
/// sources:
///
/// • Firebase Authentication
/// • Firestore Database
/// • REST APIs (Dio)
/// • Local Cache (Hive / SharedPreferences)
/// • Internet Connection
///
/// Every source throws its own exception type.
///
/// Example:
///
/// FirebaseAuthException
/// DioException
/// SocketException
/// FirebaseException
/// HiveError
///
/// If we expose these exceptions to the rest of the application,
/// every layer (Repository, Cubit, UI) must know how to deal with
/// each exception type.
///
/// This creates tightly coupled code that is difficult to maintain.
///
/// ---------------------------------------------------------------------------
/// The Solution
/// ---------------------------------------------------------------------------
///
/// Instead of exposing framework-specific exceptions,
/// every exception is classified into a generic application category.
///
/// Example:
///
/// FirebaseAuthException
///         │
///         ▼
/// ErrorCode.auth
///
/// SocketException
///         │
///         ▼
/// ErrorCode.network
///
/// FirebaseException
///         │
///         ▼
/// ErrorCode.database
///
/// This allows the rest of the application to work with a small,
/// predictable set of error categories instead of dozens of exception types.
///
/// ---------------------------------------------------------------------------
/// Why not use String?
/// ---------------------------------------------------------------------------
///
/// Wrong:
///
/// if (error.type == "Network")
///
/// Someone else may write:
///
/// "network"
/// "NETWORK"
/// "internet"
///
/// These values are inconsistent and can introduce bugs.
///
/// Using an enum guarantees that only valid categories can exist.
///
/// ---------------------------------------------------------------------------
/// When should I use ErrorCode?
/// ---------------------------------------------------------------------------
///
/// ✅ Inside custom exceptions (AppException).
///
/// ✅ Inside Failure objects.
///
/// ✅ Inside repositories when deciding how to handle an error.
///
/// ✅ Inside the UI to determine which message or screen to display.
///
/// ---------------------------------------------------------------------------
/// When should I NOT use ErrorCode?
/// ---------------------------------------------------------------------------
///
/// ❌ Don't throw ErrorCode directly.
///
/// ❌ Don't replace Exception with ErrorCode.
///
/// ❌ Don't use it to store detailed error information.
///
/// ErrorCode only answers one question:
///
/// "What type of error happened?"
///
/// ---------------------------------------------------------------------------
/// Example
/// ---------------------------------------------------------------------------
///
/// User logs in
///        │
///        ▼
/// Firebase throws:
///
/// FirebaseAuthException
///
///        │
///        ▼
/// Mapper converts it to:
///
/// AppException(
///     code: ErrorCode.auth,
///     message: "Wrong password",
/// )
///
/// Later:
///
/// switch(exception.code){
///     case ErrorCode.auth:
///         // Ask user to login again.
///         break;
///
///     case ErrorCode.network:
///         // Show "No Internet".
///         break;
/// }
///
/// The UI doesn't care whether the error came from Firebase,
/// Dio, Firestore or another library.
///
/// It only cares about the error category
///

//!══════════════════════════════════════════════════════════════════════════════

enum ErrorCode { network, auth, database, server, cache, validation, unknown ,
  timeout,
}
 

 //!________________________________________________________________________________________


//?  EX

///switch(state.error.code){

// case ErrorCode.network:

// showNoInternetScreen();

// break;

// case ErrorCode.auth:

// AppToast.show(
// description: state.error.message,
// );

// break;

// case ErrorCode.server:

// showServerDialog();

// break;

// }
