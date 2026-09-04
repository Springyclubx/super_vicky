// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "authConfigurationError": MessageLookupByLibrary.simpleMessage(
      "O login está temporariamente indisponível. Tente novamente mais tarde.",
    ),
    "authInvalidCredentials": MessageLookupByLibrary.simpleMessage(
      "E-mail ou senha incorretos.",
    ),
    "authInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "O endereço de e-mail não é válido.",
    ),
    "authNetworkUnavailable": MessageLookupByLibrary.simpleMessage(
      "Sem conexão com a internet. Verifique sua rede e tente novamente.",
    ),
    "authOperationNotAllowed": MessageLookupByLibrary.simpleMessage(
      "O login por e-mail e senha não está habilitado.",
    ),
    "authTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Muitas tentativas. Tente novamente mais tarde.",
    ),
    "authUnknown": MessageLookupByLibrary.simpleMessage(
      "Algo deu errado. Tente novamente.",
    ),
    "authUserDisabled": MessageLookupByLibrary.simpleMessage(
      "Esta conta foi desativada.",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
    "hidePassword": MessageLookupByLibrary.simpleMessage("Ocultar senha"),
    "loginButton": MessageLookupByLibrary.simpleMessage("Entrar"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Entre para continuar",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Bem-vindo de volta"),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Senha"),
    "showPassword": MessageLookupByLibrary.simpleMessage("Mostrar senha"),
    "validationEmailInvalid": MessageLookupByLibrary.simpleMessage(
      "Digite um e-mail válido",
    ),
    "validationEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Digite seu e-mail",
    ),
    "validationPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Digite sua senha",
    ),
  };
}
