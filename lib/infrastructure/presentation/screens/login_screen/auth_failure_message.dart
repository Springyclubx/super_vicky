import '../../../../domain/failures/auth_failure.dart';
import '../../../../generated/l10n.dart';

/// Maps an [AuthFailure] to a localized, user-facing message.
///
/// Lives in the presentation layer because it depends on [S] (localization).
/// This keeps raw error mapping ([AuthErrorMapper]) in infrastructure and the
/// domain [AuthFailure] free of any string/localization concerns.
extension AuthFailureMessage on AuthFailure {
  /// The localized message for this failure using the provided [s].
  String localized(S s) {
    switch (this) {
      case AuthFailure.invalidEmail:
        return s.authInvalidEmail;
      case AuthFailure.emptyEmail:
        return s.validationEmailRequired;
      case AuthFailure.emptyPassword:
        return s.validationPasswordRequired;
      case AuthFailure.invalidCredentials:
        return s.authInvalidCredentials;
      case AuthFailure.userDisabled:
        return s.authUserDisabled;
      case AuthFailure.tooManyRequests:
        return s.authTooManyRequests;
      case AuthFailure.networkUnavailable:
        return s.authNetworkUnavailable;
      case AuthFailure.operationNotAllowed:
        return s.authOperationNotAllowed;
      case AuthFailure.configurationError:
        return s.authConfigurationError;
      case AuthFailure.unknown:
        return s.authUnknown;
    }
  }
}
