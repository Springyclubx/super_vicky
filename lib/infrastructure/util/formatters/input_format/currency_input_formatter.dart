import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../presentation/constants/text_constants.dart';

/// Formatter of money for example $2.33
class CurrencyTextInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.simpleCurrency(
    decimalDigits: 2,
    name: 'BRL',
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty ||
        double.tryParse(newValue.text.replaceAll(RegExp(r'[^0-9]'), '')) ==
            null) {
      return const TextEditingValue(
        text: TextConstants.valueMoney,
        selection: TextSelection.collapsed(
          offset: 5,
        ),
      );
    }

    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (filteredText.isEmpty || double.tryParse(filteredText) == null) {
      return const TextEditingValue(
        text: TextConstants.valueMoney,
        selection: TextSelection.collapsed(offset: 5),
      );
    }

    double value = double.parse(filteredText) / 100;
    String formattedValue = _formatter.format(value);

    if (formattedValue == TextConstants.valueMoney) {
      formattedValue = TextConstants.valueMoney;
    }

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
