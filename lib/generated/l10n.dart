// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome back`
  String get loginTitle {
    return Intl.message('Welcome back', name: 'loginTitle', desc: '', args: []);
  }

  /// `Sign in to continue`
  String get loginSubtitle {
    return Intl.message(
      'Sign in to continue',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Show password`
  String get showPassword {
    return Intl.message(
      'Show password',
      name: 'showPassword',
      desc: '',
      args: [],
    );
  }

  /// `Hide password`
  String get hidePassword {
    return Intl.message(
      'Hide password',
      name: 'hidePassword',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get loginButton {
    return Intl.message('Log in', name: 'loginButton', desc: '', args: []);
  }

  /// `Enter your email`
  String get validationEmailRequired {
    return Intl.message(
      'Enter your email',
      name: 'validationEmailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get validationEmailInvalid {
    return Intl.message(
      'Enter a valid email address',
      name: 'validationEmailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get validationPasswordRequired {
    return Intl.message(
      'Enter your password',
      name: 'validationPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `The email address is not valid.`
  String get authInvalidEmail {
    return Intl.message(
      'The email address is not valid.',
      name: 'authInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password.`
  String get authInvalidCredentials {
    return Intl.message(
      'Incorrect email or password.',
      name: 'authInvalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `This account has been disabled.`
  String get authUserDisabled {
    return Intl.message(
      'This account has been disabled.',
      name: 'authUserDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later.`
  String get authTooManyRequests {
    return Intl.message(
      'Too many attempts. Please try again later.',
      name: 'authTooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection. Check your network and try again.`
  String get authNetworkUnavailable {
    return Intl.message(
      'No internet connection. Check your network and try again.',
      name: 'authNetworkUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Email and password sign-in is not enabled.`
  String get authOperationNotAllowed {
    return Intl.message(
      'Email and password sign-in is not enabled.',
      name: 'authOperationNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Sign-in is temporarily unavailable. Please try again later.`
  String get authConfigurationError {
    return Intl.message(
      'Sign-in is temporarily unavailable. Please try again later.',
      name: 'authConfigurationError',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get authUnknown {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'authUnknown',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
