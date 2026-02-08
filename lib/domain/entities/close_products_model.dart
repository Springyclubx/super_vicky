import 'package:super_vicky/domain/entities/person_model/person_model.dart';
import 'package:super_vicky/domain/entities/product_model.dart';
import 'package:super_vicky/extension/util.dart';

/// Class contains all close products in period
class CloseProductsModel {
  /// Default constructor
  CloseProductsModel({
    required this.items,
    this.startDate,
    this.endDate,
    this.person,
  });

  /// CloseProductsModel is [items]
  final List<ProductModel> items;

  /// CloseProductsModel is [person]
  final PersonModel? person;

  /// CloseProductsModel is [startDate]
  final DateTime? startDate;

  /// CloseProductsModel is [endDate]
  final DateTime? endDate;

  /// Date format in default dd/MM/yyyy [startDate]
  String? get startDateFormat {
    return tryFormatDate('dd/MM/yyy', startDate);
  }

  /// Date format in default dd/MM/yyyy [endDate]
  String? get endDateFormat {
    return tryFormatDate('dd/MM/yyy', endDate);
  }

  /// Calculated all value based in [items]
  double get valorTotal {
    var value = 0.0;

    for (final item in items) {
      value = value + item.value;
    }

    return value;
  }

  /// Title of show with details show start and end date
  String get title {
    final labelTotalValue = 'Valor total: $valorTotal';

    if (endDate == null || startDate == null) {
      return labelTotalValue;
    }

    return '$startDateFormat à $endDateFormat - Valor total: $valorTotal';
  }
}
