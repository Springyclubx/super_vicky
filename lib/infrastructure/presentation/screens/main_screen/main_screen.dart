import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_vicky/domain/entities/product_model.dart';
import 'package:super_vicky/extension/string_util.dart';
import 'package:super_vicky/infrastructure/presentation/states/product_list_state.dart';

import '../../../../domain/constants/route_default.dart';
import '../../../../domain/entities/close_products_model.dart';
import '../../../../extension/util.dart';
import '../../../../main.dart';
import '../../../util/exports_widget.dart';
import '../../states/login_state.dart';
import '../login_screen/login_screen.dart';

part 'widget/item_widget.dart';

part 'widget/list_view_widget.dart';

/// Main screen with list all registered items
class MainScreen extends StatelessWidget {
  /// Default screen
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(
          builder: (context, auth, _) {
            if (auth.user != null) {
              return const _ListProducts();
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

class _ListProducts extends StatelessWidget {
  const _ListProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(context: context, title: 'sem titulo'),
      body: const _ListViewWidget(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.add),
            ),
            Text('Adicionar'),
          ],
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(RouteDefault.formScreen);
        },
      ),
    );
  }
}
