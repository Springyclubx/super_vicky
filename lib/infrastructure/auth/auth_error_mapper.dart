import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/failures/auth_failure.dart';

/// Maps raw authentication errors (Firebase / platform-channel exceptions)
/// into a domain [AuthFailure].
///
/// This is the single boundary where Firebase/Pigeon error details are
/// interpreted. Callers must expose only the resulting [AuthFailure] — never
/// the original exception text — so raw provider or platform-channel strings
/// (such as the Pigeon method name) can never reach the user.
class AuthErrorMapper {
  /// Creates a const mapper.
  const AuthErrorMapper();

  /// Classifies [error] into an [AuthFailure]. Always returns a value; unknown
  /// or unexpected errors collapse to [AuthFailure.unknown].
  AuthFailure map(Object error) {
    if (error is FirebaseAuthException) {
      final code = error.code.toLowerCase();
      final message = (error.message ?? '').toUpperCase();

      // A missing backend configuration frequently arrives either as a
      // dedicated code or wrapped inside a generic internal error.
      if (code == 'configuration-not-found' ||
          message.contains('CONFIGURATION_NOT_FOUND')) {
        return AuthFailure.configurationError;
      }

      switch (code) {
        case 'invalid-email':
          return AuthFailure.invalidEmail;
        case 'user-disabled':
          return AuthFailure.userDisabled;
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
        case 'invalid-login-credentials':
          return AuthFailure.invalidCredentials;
        case 'too-many-requests':
          return AuthFailure.tooManyRequests;
        case 'network-request-failed':
          return AuthFailure.networkUnavailable;
        case 'operation-not-allowed':
          return AuthFailure.operationNotAllowed;
      }

      return AuthFailure.unknown;
    }

    return AuthFailure.unknown;
  }
}
