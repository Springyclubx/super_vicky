import 'package:flutter/material.dart';
import 'package:super_vicky/extension/context_util.dart';

class ColorDefaultConstants {
  ColorDefaultConstants({required this.context});

  final BuildContext context;

  bool get isDark => context.isDarkTheme;

  static const Color mainColorLight = Color(0xFFFA8072);
  static const Color backGroundColorLight = Color(0xFFFFE3DD);
  static const Color secondColorLight = Color(0xFFA787E1);
  static const Color offColorLight = Color(0xFF000000);

  static const Color mainColorDark = Color(0xFFFA8072); // tom avermelhado mais fechado
  static const Color backGroundColorDark = Color(0xFF0C0A0A); // fundo escuro padrão
  static const Color secondColorDark = Color(0xFF584577); // lilás mais sóbrio, combina no dark
  static const Color offColorDark = Color(0xFFFFFFFF); // texto principal sobre fundo escuro

  /// Getters automáticos (usam o modo atual)
  Color get mainColor => isDark ? mainColorDark : mainColorLight;

  Color get backGroundColor =>
      isDark ? backGroundColorDark : backGroundColorLight;

  Color get secondColor => isDark ? secondColorDark : secondColorLight;

  Color get offColor => isDark ? offColorDark : offColorLight;
}
