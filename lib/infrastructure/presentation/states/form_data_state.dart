import 'package:flutter/cupertino.dart';
import 'package:super_vicky/infrastructure/util/exports_widget.dart';

/// Controller state of Form data of application
class FormDataState extends ChangeNotifier {
  final _modelController = TextEditingController();
  final _dateController = TextEditingController();
  final _codeController = TextEditingController();
  final _quantityController = TextEditingController();
  final _valueController = TextEditingController();

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

  /// Method for select date and populate in controller [_dateController]
  void selectDate(String dateFormat) {
    _dateController.text = dateFormat;
    notifyListeners();
  }
}
