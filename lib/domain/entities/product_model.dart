import '../../extension/util.dart';

/// A model that represents a product with detailed information.
///
/// The [ProductModel] class contains data such as the creation date, model, code,
/// quantity, and unit value of a product. It also provides methods to format the
/// creation hour and calculate the total value based on quantity and unit price.
class ProductModel {
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
  String? get createdHour => tryFormatDate('HH:dd', date);

  /// Calculates the total value of the product (quantity * unit price).
  ///
  /// Returns the total value as a string.
  String? get totalValue => (quantity * value).toString();
}
