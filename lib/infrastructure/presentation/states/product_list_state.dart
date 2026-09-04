import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:super_vicky/domain/entities/product_model.dart';

import '../../../domain/entities/close_products_model.dart';

///
class ProductListState extends ChangeNotifier {
  /// Constructor for init
  ProductListState() {
    getAllProducts();
  }

  final _items = <CloseProductsModel>[];

  /// Registered items on return [_items]
  List<CloseProductsModel> get items => _items;

  Future<void> initState() async {
    // _items.addAll(
    //   await getAllProducts(),
    // );
  }

  Future<List<ProductModel>> getAllProducts() async {
    final firestore = FirebaseFirestore.instance;

    final snapshot = await firestore.collection('products').get();

    return snapshot.docs.map((doc) {
      return ProductModel.fromDocument(doc);
    }).toList();
  }
}
