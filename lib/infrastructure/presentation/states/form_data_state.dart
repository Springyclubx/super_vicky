import 'package:flutter/cupertino.dart';
import 'package:super_vicky/extension/util.dart';
import 'package:super_vicky/infrastructure/util/exports_widget.dart';
import 'package:super_vicky/infrastructure/util/formatters/parse/extractor_number_per_string_parse.dart';

import '../../../domain/constants/format_date_constants.dart';
import '../constants/text_constants.dart';

/// Controller state of Form data of application
class FormDataState extends ChangeNotifier {
  /// Constructor for init
  FormDataState() {
    _init();
  }

  final _modelController = TextEditingController();
  final _dateController = TextEditingController();
  final _hourController = TextEditingController();
  final _codeController = TextEditingController();
  final _quantityController = TextEditingController();
  final _valueController = TextEditingController();
  final _totalValueController = TextEditingController();

  /// Controller of hour for date in [TextFormDefault]
  TextEditingController get hourController => _hourController;

  /// Controller of total value multiply quantity by value in [TextFormDefault]
  TextEditingController get totalValueController => _totalValueController;

  /// Controller of date in [TextFormDefault]
  TextEditingController get dateController => _dateController;

  /// Controller of mode in [TextFormDefault]
  TextEditingController get modelController => _modelController;

  /// Controller of code in [TextFormDefault]
  TextEditingController get codeController => _codeController;

  /// Controller of quantity in [TextFormDefault]
  TextEditingController get quantityController => _quantityController;

  /// Controller of value in [TextFormDefault]
  TextEditingController get valueController => _valueController;

  Future<void> _init() async {
    final now = DateTime.now();

    _dateController.text = tryFormatDate(FormatDate.dateMonthYear, now) ?? '';
    _hourController.text = tryFormatDate(FormatDate.hourMinute, now) ?? '';
    _valueController.text = TextConstants.valueMoney;

    _quantityController.addListener(
      () => _addTotalValue(),
    );
    _valueController.addListener(
      () => _addTotalValue(),
    );
  }

  void _addTotalValue() {
    if (_valueController.text.isEmpty || _quantityController.text.isEmpty) {
      return;
    }
    final finalValue = _multiplyQuantityByValue();

    if (finalValue == 0) {
      return;
    }

    _totalValueController.text = FormattedNumber.formatValue(finalValue);
  }

  /// Method just reload
  void reload() {
    notifyListeners();
  }

  double _multiplyQuantityByValue() {
    final hourNumber = int.parse(_quantityController.text);
    final quantityNumber = FormattedNumber.extractValue(_valueController.text);

    final value = hourNumber * quantityNumber;

    return value;
  }

  /// Method for select date and populate in controller [_dateController]
  void selectDate(String dateFormat) {
    _dateController.text = dateFormat;
    notifyListeners();
  }
}
