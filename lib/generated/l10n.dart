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
// ignore_for_file:public_member_api_docs

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Unexpected error, please try again later`
  String get unknownError {
    return Intl.message(
      'Unexpected error, please try again later',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcomeLogin {
    return Intl.message(
      'Welcome!',
      name: 'welcomeLogin',
      desc: '',
      args: [],
    );
  }

  /// `Log in with your information below:`
  String get loginInfo {
    return Intl.message(
      'Log in with your information below:',
      name: 'loginInfo',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Back to login`
  String get backToLogin {
    return Intl.message(
      'Back to login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Recover Password`
  String get recoverPassword {
    return Intl.message(
      'Recover Password',
      name: 'recoverPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your registration email so we can send you the link for a new password.`
  String get forgotPasswordDescription {
    return Intl.message(
      'Enter your registration email so we can send you the link for a new password.',
      name: 'forgotPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get emptyFieldValidation {
    return Intl.message(
      'This field is required',
      name: 'emptyFieldValidation',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Close menu`
  String get closeMenu {
    return Intl.message(
      'Close menu',
      name: 'closeMenu',
      desc: '',
      args: [],
    );
  }

  /// `Fix sidebar`
  String get fixSideBar {
    return Intl.message(
      'Fix sidebar',
      name: 'fixSideBar',
      desc: '',
      args: [],
    );
  }

  /// `Close sidebar`
  String get closeSideBar {
    return Intl.message(
      'Close sidebar',
      name: 'closeSideBar',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect e-mail or password`
  String get invalidCredentials {
    return Intl.message(
      'Incorrect e-mail or password',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Blocked`
  String get blocked {
    return Intl.message(
      'Blocked',
      name: 'blocked',
      desc: '',
      args: [],
    );
  }

  /// `Keep opened`
  String get keepOpened {
    return Intl.message(
      'Keep opened',
      name: 'keepOpened',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to quit? All changes will be discarded.`
  String get exitDescription {
    return Intl.message(
      'Are you sure you want to quit? All changes will be discarded.',
      name: 'exitDescription',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Clicking confirm will return you to the home screen, not completing the process.`
  String get clickingConfirm {
    return Intl.message(
      'Clicking confirm will return you to the home screen, not completing the process.',
      name: 'clickingConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Is sure?`
  String get isSure {
    return Intl.message(
      'Is sure?',
      name: 'isSure',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get news {
    return Intl.message(
      'News',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error`
  String get unexpectedError {
    return Intl.message(
      'Unexpected error',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `There are {quantity} employees already registered in the file, do you want to replace these users and finish the import? \n\nRows with duplicate users {listRows}`
  String unexpectedErrorDescription(Object quantity, Object listRows) {
    return Intl.message(
      'There are $quantity employees already registered in the file, do you want to replace these users and finish the import? \n\nRows with duplicate users $listRows',
      name: 'unexpectedErrorDescription',
      desc: '',
      args: [quantity, listRows],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcomePanel {
    return Intl.message(
      'Welcome',
      name: 'welcomePanel',
      desc: '',
      args: [],
    );
  }

  /// `{seconds} second{s} ago`
  String secondsAgo(Object seconds, Object s) {
    return Intl.message(
      '$seconds second$s ago',
      name: 'secondsAgo',
      desc: '',
      args: [seconds, s],
    );
  }

  /// `{minutes} minute{s} ago`
  String minutesAgo(Object minutes, Object s) {
    return Intl.message(
      '$minutes minute$s ago',
      name: 'minutesAgo',
      desc: '',
      args: [minutes, s],
    );
  }

  /// `{hours} hour{s} ago`
  String hoursAgo(Object hours, Object s) {
    return Intl.message(
      '$hours hour$s ago',
      name: 'hoursAgo',
      desc: '',
      args: [hours, s],
    );
  }

  /// `{days} day{s} ago`
  String daysAgo(Object days, Object s) {
    return Intl.message(
      '$days day$s ago',
      name: 'daysAgo',
      desc: '',
      args: [days, s],
    );
  }

  /// `{month} {day}, {year}`
  String feedDate(Object month, Object day, Object year) {
    return Intl.message(
      '$month $day, $year',
      name: 'feedDate',
      desc: '',
      args: [month, day, year],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message(
      'Read more',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Read less`
  String get readLess {
    return Intl.message(
      'Read less',
      name: 'readLess',
      desc: '',
      args: [],
    );
  }

  /// `interactions`
  String get interactions {
    return Intl.message(
      'interactions',
      name: 'interactions',
      desc: '',
      args: [],
    );
  }

  /// `interaction`
  String get interaction {
    return Intl.message(
      'interaction',
      name: 'interaction',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Love`
  String get love {
    return Intl.message(
      'Love',
      name: 'love',
      desc: '',
      args: [],
    );
  }

  /// `Like`
  String get like {
    return Intl.message(
      'Like',
      name: 'like',
      desc: '',
      args: [],
    );
  }

  /// `Great`
  String get great {
    return Intl.message(
      'Great',
      name: 'great',
      desc: '',
      args: [],
    );
  }

  /// `Funny`
  String get funny {
    return Intl.message(
      'Funny',
      name: 'funny',
      desc: '',
      args: [],
    );
  }

  /// `Interact`
  String get interact {
    return Intl.message(
      'Interact',
      name: 'interact',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get photo {
    return Intl.message(
      'Photo',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `Fechar`
  String get close {
    return Intl.message(
      'Fechar',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `The file has exceeded the maximum allowed size ({size}kb)`
  String fileSize(Object size) {
    return Intl.message(
      'The file has exceeded the maximum allowed size (${size}kb)',
      name: 'fileSize',
      desc: '',
      args: [size],
    );
  }

  /// `This file format is invalid, try another file with {format} format`
  String invalidFormatDescription(Object format) {
    return Intl.message(
      'This file format is invalid, try another file with $format format',
      name: 'invalidFormatDescription',
      desc: '',
      args: [format],
    );
  }

  /// `Invalid format`
  String get invalidFormat {
    return Intl.message(
      'Invalid format',
      name: 'invalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `Answer`
  String get answer {
    return Intl.message(
      'Answer',
      name: 'answer',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Image error`
  String get imageError {
    return Intl.message(
      'Image error',
      name: 'imageError',
      desc: '',
      args: [],
    );
  }

  /// `Post something new, now on Syync`
  String get newPostSyync {
    return Intl.message(
      'Post something new, now on Syync',
      name: 'newPostSyync',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Add poll`
  String get addPoll {
    return Intl.message(
      'Add poll',
      name: 'addPoll',
      desc: '',
      args: [],
    );
  }

  /// `Add video`
  String get addVideo {
    return Intl.message(
      'Add video',
      name: 'addVideo',
      desc: '',
      args: [],
    );
  }

  /// `Add image`
  String get addImage {
    return Intl.message(
      'Add image',
      name: 'addImage',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Create post`
  String get createPost {
    return Intl.message(
      'Create post',
      name: 'createPost',
      desc: '',
      args: [],
    );
  }

  /// `Select a URL to continue`
  String get selectURL {
    return Intl.message(
      'Select a URL to continue',
      name: 'selectURL',
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
