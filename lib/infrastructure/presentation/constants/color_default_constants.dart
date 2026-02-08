import 'package:flutter/material.dart';
import 'package:super_vicky/extension/context_util.dart';

/// A utility class that provides color constants for both light and dark themes.
///
/// The [ColorDefaultConstants] class manages color values that change based on the
/// current theme (light or dark). It defines colors for main background, secondary
/// elements, and text, providing a consistent appearance across the application.
///
/// The colors are defined for both light and dark modes, with automatic getters
/// that select the appropriate colors based on the current theme.
///
/// Example usage:
/// ```dart
/// final colorConstants = ColorDefaultConstants(context: context);
/// Color mainColor = colorConstants.mainColor;
/// Color backgroundColor = colorConstants.backGroundColor;
/// ```
class ColorDefaultConstants {
  /// Creates an instance of [ColorDefaultConstants].
  ///
  /// The parameter [context] is required to access the current theme.
  /// - [context]: The build context to determine the current theme (light or dark).
  ColorDefaultConstants({required this.context});

  /// The [BuildContext] to access the current theme.
  final BuildContext context;

  /// Returns `true` if the current theme is dark, `false` otherwise.
  bool get isDark => context.isDarkTheme;

  /// Light theme main color (salmon-like).
  static const Color mainColorLight = Color(0xFFFA8072);

  /// Light theme background color (light pink).
  static const Color backGroundColorLight = Color(0xFFF1E6FF);

  /// Light theme secondary color (soft purple).
  static const Color secondColorLight = Color(0xFFA787E1);

  /// Light theme off color (black).
  static const Color offColorLight = Color(0xFF000000);

  /// Dark theme main color (darker red-tone).
  static const Color mainColorDark = Color(
    0xFFFA8072,
  ); // A darker reddish tone.

  /// Dark theme background color (dark standard background).
  static const Color backGroundColorDark = Color(0xFF2C1F3A);

  /// Dark theme secondary color (muted lavender).
  static const Color secondColorDark = Color(
    0xFF584577,
  ); // A more sober lilac, matches dark mode.

  /// Dark theme off color (white, for text).
  static const Color offColorDark = Color(
    0xFFFFFFFF,
  ); // White text on dark background.

  /// Automatically selects the main color based on the current theme.
  ///
  /// Returns [mainColorDark] if the theme is dark, otherwise [mainColorLight].
  Color get mainColor => isDark ? mainColorDark : mainColorLight;

  /// Automatically selects the background color based on the current theme.
  ///
  /// Returns [backGroundColorDark] if the theme is dark, otherwise [backGroundColorLight].
  Color get backGroundColor =>
      isDark ? backGroundColorDark : backGroundColorLight;

  /// Automatically selects the secondary color based on the current theme.
  ///
  /// Returns [secondColorDark] if the theme is dark, otherwise [secondColorLight].
  Color get secondColor => isDark ? secondColorDark : secondColorLight;

  /// Automatically selects the off color (for text or other elements) based on the current theme.
  ///
  /// Returns [offColorDark] if the theme is dark, otherwise [offColorLight].
  Color get offColor => isDark ? offColorDark : offColorLight;
}
