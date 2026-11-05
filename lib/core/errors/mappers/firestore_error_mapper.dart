import 'package:firebase_core/firebase_core.dart';

import '../../constants/error_messages.dart';
import '../app_exception.dart';

class FirestoreErrorMapper {
  const FirestoreErrorMapper._();

  static DatabaseException map(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return const DatabaseException(AppErrorMessages.permissionDenied);

      case 'not-found':
        return const DatabaseException(AppErrorMessages.documentNotFound);

      case 'already-exists':
        return const DatabaseException(AppErrorMessages.documentAlreadyExists);

      case 'cancelled':
        return const DatabaseException(AppErrorMessages.operationCancelled);

      case 'data-loss':
        return const DatabaseException(AppErrorMessages.dataLoss);

      case 'deadline-exceeded':
        return const DatabaseException(AppErrorMessages.requestTimeout);

      case 'failed-precondition':
        return const DatabaseException(AppErrorMessages.failedPrecondition);

      case 'internal':
        return const DatabaseException(AppErrorMessages.internalServerError);

      case 'invalid-argument':
        return const DatabaseException(AppErrorMessages.invalidArgument);

      case 'out-of-range':
        return const DatabaseException(AppErrorMessages.outOfRange);

      case 'resource-exhausted':
        return const DatabaseException(AppErrorMessages.resourceExhausted);

      case 'unauthenticated':
        return const DatabaseException(AppErrorMessages.unauthenticated);

      case 'unavailable':
        return const DatabaseException(AppErrorMessages.serviceUnavailable);

      case 'unimplemented':
        return const DatabaseException(AppErrorMessages.featureNotImplemented);

      default:
        return DatabaseException(
          error.message ?? AppErrorMessages.databaseError,
        );
    }
  }
}
