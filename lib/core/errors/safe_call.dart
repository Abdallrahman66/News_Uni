import 'app_error_handler.dart';

// Future<UserCredential> login(...) {
// return safeCall(() async {
// return await firebaseAuth.signInWithEmailAndPassword(...);
// });
// }
Future<T> safeCall<T>(Future<T> Function() action) async {
  try {
    return await action();
  } catch (e) {
    ErrorHandler.handle(e);
  }
}
