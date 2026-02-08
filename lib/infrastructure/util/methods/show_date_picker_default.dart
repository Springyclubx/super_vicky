import 'package:flutter/material.dart';
import 'package:super_vicky/extension/util.dart';

import '../../../domain/constants/format_date_constants.dart';

/// Method just for show showDatePicker in flutter default
Future<(DateTime?, String)> showDatePickerDefault({
  required BuildContext context,
  required DateTime firstDate,
  required DateTime lastDate,
  DateTime? initialDate,
}) async {
  final date = await showDatePicker(
    context: context,
    firstDate: firstDate,
    lastDate: lastDate,
    initialDate: initialDate,
  );

  if (date == null) {
    return (null, '');
  }
  final dateFormat = tryFormatDate(FormatDate.dateMonthYear, date);
  return (date, dateFormat ?? '');
}
