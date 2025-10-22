import 'package:super_vicky/domain/entities/product_model.dart';
import 'package:super_vicky/extension/util.dart';

/// Class contains all close products in period
class CloseProductsModel {
  /// Default constructor
  CloseProductsModel({
    required this.items,
    this.startDate,
    this.endDate,
    this.valorTotal,
  });

  /// CloseProductsModel is [items]
  final List<ProductModel> items;

  /// CloseProductsModel is [startDate]
  final DateTime? startDate;

  /// CloseProductsModel is [endDate]
  final DateTime? endDate;

  /// CloseProductsModel is [valorTotal]
  final double? valorTotal;

  /// Date format in default dd/MM/yyyy [startDate]
  String? get startDateFormat {
    return tryFormatDate('dd/MM/yyy', startDate);
  }

  /// Date format in default dd/MM/yyyy [endDate]
  String? get endDateFormat {
    return tryFormatDate('dd/MM/yyy', endDate);
  }

  /// Title of show with details show start and end date
  String get title {
    return '$startDateFormat à $endDateFormat - Valor total: $valorTotal';
  }
}
