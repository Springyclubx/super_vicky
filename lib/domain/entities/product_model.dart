import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_vicky/domain/entities/default_model.dart';

import '../../extension/util.dart';
import '../constants/format_date_constants.dart';

/// A model that represents a product with detailed information.
///
/// The [ProductModel] class contains data such as the creation date, model, code,
/// quantity, and unit value of a product. It also provides methods to format the
/// creation hour and calculate the total value based on quantity and unit price.
class ProductModel extends DefaultModel {
  /// Creates an instance of [ProductModel].
  ///
  /// The parameters are required:
  /// - [date]: The creation date and time of the product.
  /// - [model]: The product model.
  /// - [code]: The unique product code.
  /// - [quantity]: The quantity of the product.
  /// - [value]: The unit price of the product.
  ProductModel({
    required this.date,
    required this.model,
    required this.code,
    required this.quantity,
    required this.value,
  });

  /// The creation date and time of the product.
  final DateTime date;

  /// The product model.
  final String model;

  /// The unique product code.
  final String code;

  /// The quantity of the product.
  final double quantity;

  /// The unit price of the product.
  final double value;

  /// Returns the formatted creation hour of the product, in 'HH:dd' format.
  ///
  /// Returns `null` if the formatting fails.
  String? get createdHour => tryFormatDate(FormatDate.dateHourMinute, date);

  /// Returns the formatted creation hour of the product, in 'dd/MM/yyyy' format.
  ///
  /// Returns `null` if the formatting fails.
  String? get createdDate => tryFormatDate(FormatDate.dateMonthYear, date);

  /// Calculates the total value of the product (quantity * unit price).
  ///
  /// Returns the total value as a string.
  String? get totalValue => (quantity * value).toString();

  /// Creates an instance of [ProductModel] from a JSON map.
  ///
  /// Expects the same shape produced by [toJson].
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rawDate = json['date'];

    final parsedDate = rawDate is Timestamp
        ? rawDate.toDate()
        : rawDate as DateTime;

    return ProductModel(
      model: json['model'] ?? '',
      code: json['code'] ?? '',
      quantity: (json['quantity'] as num).toDouble(),
      value: (json['value'] as num).toDouble(),
      date: parsedDate,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'date': tryFormatDate(FormatDate.dateHourMinute, date),
      'model': model,
      'code': code,
      'quantity': quantity,
      'value': value,
    };
  }

  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    print(data);
    print('akjbsdlkjasbd');
    return ProductModel.fromJson(data);
  }
}
