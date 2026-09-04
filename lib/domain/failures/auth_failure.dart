/// Domain-level classification of authentication failures.
///
/// This enum is intentionally free of any Firebase or Flutter types so the
/// domain layer never depends on infrastructure. Presentation maps each value
/// to a localized, user-safe message; raw provider errors are never exposed.
enum AuthFailure {
  /// The email address is malformed.
  invalidEmail,

  /// No email was provided.
  emptyEmail,

  /// No password was provided.
  emptyPassword,

  /// Email/password combination was rejected.
  invalidCredentials,

  /// The account exists but has been disabled.
  userDisabled,

  /// Too many attempts in a short period.
  tooManyRequests,

  /// The device has no usable network connection.
  networkUnavailable,

  /// Email/password provider is not enabled for the project.
  operationNotAllowed,

  /// Backend auth configuration is unavailable (e.g. CONFIGURATION_NOT_FOUND).
  configurationError,

  /// Any other, unclassified failure.
  unknown,
}
