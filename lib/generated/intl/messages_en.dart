// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "authConfigurationError": MessageLookupByLibrary.simpleMessage(
      "Sign-in is temporarily unavailable. Please try again later.",
    ),
    "authInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Incorrect email or password.",
    ),
    "authInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "The email address is not valid.",
    ),
    "authNetworkUnavailable": MessageLookupByLibrary.simpleMessage(
      "No internet connection. Check your network and try again.",
    ),
    "authOperationNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Email and password sign-in is not enabled.",
    ),
    "authTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Too many attempts. Please try again later.",
    ),
    "authUnknown": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "authUserDisabled": MessageLookupByLibrary.simpleMessage(
      "This account has been disabled.",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Hide password"),
    "loginButton": MessageLookupByLibrary.simpleMessage("Log in"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Sign in to continue",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Welcome back"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "showPassword": MessageLookupByLibrary.simpleMessage("Show password"),
    "validationEmailInvalid": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email address",
    ),
    "validationEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Enter your email",
    ),
    "validationPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
  };
}
