import 'package:flutter/material.dart';
import 'package:super_vicky/domain/entities/product_model.dart';



///
class ProductListState extends ChangeNotifier {
  final _items = <ProductModel>[
    ProductModel(
      date: DateTime.now(),
      model: 'model',
      code: 'code',
      quantity: 2,
      value: 123,
    ),
    ProductModel(
      date: DateTime.now(),
      model: 'model',
      code: 'code',
      quantity: 2,
      value: 123,
    ),
    ProductModel(
      date: DateTime.now(),
      model: 'model',
      code: 'code',
      quantity: 2,
      value: 123,
    ),
  ];

  /// Registered items on return [_items]
  List<ProductModel> get items => _items;
}
