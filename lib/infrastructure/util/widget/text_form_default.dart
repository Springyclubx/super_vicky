import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../main.dart';

/// Item text form default on program layout
class TextFormDefault extends StatelessWidget {
  /// Some params on text form default
  const TextFormDefault({
    super.key,
    required this.hintText,
    this.suffixIcon,
    required this.controller,
    this.onFieldSubmitted,
    this.onChanged,
    this.enabled,
    this.inputFormatters,
  });

  /// Hint text for show before
  final String hintText;

  /// Suffix widget no necessary is icon
  final Widget? suffixIcon;

  /// Controller of text form
  final TextEditingController? controller;

  /// Execution method when pressing enter
  final ValueChanged<String>? onFieldSubmitted;

  /// Execution method when changing value
  final ValueChanged<String>? onChanged;

  /// List format of input
  final List<TextInputFormatter>? inputFormatters;

  /// enabled text form
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      inputFormatters: inputFormatters,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      style: TextStyle(
        fontFamily: 'inter',
        color: colorDefault.offColor,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: colorDefault.backGroundColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorDefault.secondColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'inter',
          color: colorDefault.offColor.withValues(alpha: 0.6),
        ),
        errorStyle: const TextStyle(
          fontFamily: 'inter',
        ),
        labelStyle: TextStyle(
          fontFamily: 'inter',
          color: colorDefault.offColor,
        ),
      ),
    );
  }
}
