import 'package:intl/intl.dart';

/// A utility class to handle both formatted and numeric values extracted from a string.
/// It provides methods for extracting the numeric value as a `double` and a formatted string
/// (e.g., for displaying monetary values).
class FormattedNumber {
  /// Constructor that accepts an input string and extracts both the numeric and formatted values.
  ///
  /// [input] The string from which the number will be extracted. It could be a string with formatting,
  /// such as a currency (e.g., "R$ 1.234,56").
  const FormattedNumber({
    required this.value,
    required this.formattedValue,
  });

  /// Value value
  final double value;

  /// Value formattedValue
  final String formattedValue;

  /// Private method to extract the numeric value (double) from a string.
  ///
  /// This method uses a regular expression to find all digit sequences in the string,
  /// concatenates them, and converts them into a `double` value.
  ///
  /// Example:
  /// ```dart
  /// double result = FormattedNumber._extractValue("R$ 1.234,56");
  /// print(result); // Output: 1234.56
  /// ```
  ///
  /// Returns the numeric value as a `double`.
  static double extractValue(String input) {
    // Remove all non-numeric characters except for commas and dots
    final cleanedInput = input.replaceAll(RegExp(r'[^0-9,\.]'), '');

    // Replace the first comma with a dot for proper decimal point handling
    final cleanedValue = cleanedInput.replaceFirst(',', '.');

    // Try to parse the cleaned value as a double
    final value = double.tryParse(cleanedValue) ?? 0.0;

    return value;
  }


  /// Private method to format the numeric value into a formatted string (e.g., "R$ 1.234,56").
  ///
  /// This method uses the `intl` package to format the numeric value as a currency value.
  ///
  /// Example:
  /// ```dart
  /// String result = FormattedNumber._formatValue(1234.56);
  /// print(result); // Output: "R$ 1.234,56"
  /// ```
  ///
  /// Returns the formatted string (e.g., "R$ 1.234,56").
  static String formatValue(double value) {
    final formatter = NumberFormat.simpleCurrency(
      locale: 'pt_BR',
    );
    return formatter.format(value); // Formats the numeric value as currency
  }
}
