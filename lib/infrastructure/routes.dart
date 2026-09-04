import 'package:flutter/material.dart';
import 'package:super_vicky/infrastructure/presentation/screens/main_screen/main_screen.dart';
import 'package:super_vicky/infrastructure/presentation/screens/form_data/form_data_screen.dart';

import '../domain/constants/route_default.dart';
import '../domain/entities/default_model.dart';
import '../domain/entities/product_model.dart';

/// All routes on program
Map<String, WidgetBuilder> routes() {
  return {
    RouteDefault.mainScreen: (context) => const MainScreen(),
    RouteDefault.formScreen: (context) {
      final item = convertClassJsonToModel<ProductModel>(
        context,
        ProductModel.fromJson,
      );
      return RegisterScreen(item: item);
    },
  };
}

T convertClassJsonToModel<T extends DefaultModel>(
  BuildContext context,
  T Function(Map<String, dynamic>) fromJson,
) {
  final item =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  return fromJson(item);
}
