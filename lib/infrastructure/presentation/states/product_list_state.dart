import 'package:flutter/material.dart';
import 'package:super_vicky/domain/entities/product_model.dart';

import '../../../domain/entities/close_products_model.dart';

///
class ProductListState extends ChangeNotifier {
  final _items = <CloseProductsModel>[
    CloseProductsModel(
      endDate: DateTime.now().subtract(const Duration(days: 30)),
      startDate: DateTime.now(),
      items: [
        ProductModel(
          date: DateTime.now().add(const Duration(days: 21)),
          model: 'model',
          code: 'code',
          quantity: 2,
          value: 123,
        ),   ProductModel(
          date: DateTime.now().add(const Duration(days: 21)),
          model: 'model',
          code: 'code',
          quantity: 2,
          value: 123,
        ),   ProductModel(
          date: DateTime.now().add(const Duration(days: 21)),
          model: 'model',
          code: 'code',
          quantity: 2,
          value: 123,
        ),
      ],
    ),    CloseProductsModel(
      endDate: DateTime.now().subtract(const Duration(days: 30)),
      startDate: DateTime.now(),
      items: [
        ProductModel(
          date: DateTime.now().add(const Duration(days: 21)),
          model: 'model',
          code: 'code',
          quantity: 2,
          value: 123,
        ),     ProductModel(
          date: DateTime.now().add(const Duration(days: 21)),
          model: 'model',
          code: 'code',
          quantity: 2,
          value: 123,
        ),
      ],
    ),    CloseProductsModel(
      endDate: DateTime.now().subtract(const Duration(days: 30)),
      startDate: DateTime.now(),
      items: [
        ProductModel(
          date: DateTime.now().add(const Duration(days: 21)),
          model: 'model',
          code: 'code',
          quantity: 2,
          value: 123,
        ),        ProductModel(
          date: DateTime.now().add(const Duration(days: 21)),
          model: 'model',
          code: 'code',
          quantity: 2,
          value: 123,
        ),        ProductModel(
          date: DateTime.now().add(const Duration(days: 21)),
          model: 'model',
          code: 'code',
          quantity: 2,
          value: 123,
        ),
      ],
    ),
  ];

  /// Registered items on return [_items]
  List<CloseProductsModel> get items => _items;
}
