// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "authConfigurationError": MessageLookupByLibrary.simpleMessage(
      "El inicio de sesión no está disponible temporalmente. Inténtalo de nuevo más tarde.",
    ),
    "authInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Correo electrónico o contraseña incorrectos.",
    ),
    "authInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "La dirección de correo electrónico no es válida.",
    ),
    "authNetworkUnavailable": MessageLookupByLibrary.simpleMessage(
      "Sin conexión a internet. Comprueba tu red e inténtalo de nuevo.",
    ),
    "authOperationNotAllowed": MessageLookupByLibrary.simpleMessage(
      "El inicio de sesión con correo y contraseña no está habilitado.",
    ),
    "authTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Demasiados intentos. Inténtalo de nuevo más tarde.",
    ),
    "authUnknown": MessageLookupByLibrary.simpleMessage(
      "Algo salió mal. Inténtalo de nuevo.",
    ),
    "authUserDisabled": MessageLookupByLibrary.simpleMessage(
      "Esta cuenta ha sido deshabilitada.",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Ocultar contraseña"),
    "loginButton": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Inicia sesión para continuar",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Bienvenido de nuevo"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Contraseña"),
    "showPassword": MessageLookupByLibrary.simpleMessage("Mostrar contraseña"),
    "validationEmailInvalid": MessageLookupByLibrary.simpleMessage(
      "Introduce un correo electrónico válido",
    ),
    "validationEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Introduce tu correo electrónico",
    ),
    "validationPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Introduce tu contraseña",
    ),
  };
}
