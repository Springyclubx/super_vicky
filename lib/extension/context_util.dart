import 'package:flutter/material.dart';

/// Get defaults that use of [BuildContext]
extension BuildContextExtension on BuildContext {
  /// Returns class default of fluent [typography]
  /// title, subTitle, body, bodyStrong ...
  TextTheme get typography => Theme.of(this).textTheme;

  /// Media query of screen // context
  Size get media => MediaQuery.sizeOf(this);

  /// Validates if the program has a dark theme
  bool get isDarkTheme {


    return Theme.brightnessOf(this) == Brightness.dark;
  }
}
