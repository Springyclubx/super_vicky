import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

DateTime? tryParseDate(String template, String? date) {
  if (date == null || date.isEmpty) {
    return null;
  }

  try {
    return DateFormat(template).parseStrict(date);
  } on FormatException catch (e, stack) {
    logFailString('Error parsing date $e, stask: $stack');
    return null;
  }
}

/// Try to format the provided date as string with the provided format template.
/// Returns null if the date can't be parsed as a string
String? tryFormatDate(String template, DateTime? date) {
  if (date == null) {
    return null;
  }

  try {
    return DateFormat(template).format(date);
  } on FormatException catch (e, stack) {
    logFailString('Error formatting date $e stack: $stack');
    return null;
  }
}

/// Print a fail request message
void logFailString(String messageError) {
  Logger(
    output: ConsoleOutput(),
    printer: SimplePrinter(printTime: true, colors: true),
  ).e(messageError);
}
