import 'package:flutter/services.dart';

/// Class default for hour input format
class HourInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.length > 2 && newText.length <= 4) {
      newText = '${newText.substring(0, 2)}:${newText.substring(2)}';
    } else if (newText.length > 4) {
      newText = '${newText.substring(0, 2)}:${newText.substring(2, 4)}';
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
    );
  }
}
