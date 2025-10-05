class ProductModel {
  ProductModel({
    required this.date,
    required this.model,
    required this.code,
    required this.quantity,
    required this.value,
    required this.totalValue,
  });

  final DateTime date;
  final String model;
  final String code;
  final double quantity;
  final double value;
  final double totalValue;
}
