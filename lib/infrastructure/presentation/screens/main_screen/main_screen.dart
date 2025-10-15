import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_vicky/domain/entities/product_model.dart';
import 'package:super_vicky/extension/string_util.dart';
import 'package:super_vicky/infrastructure/presentation/states/product_list_state.dart';

import '../../../../domain/constants/route_default.dart';
import '../../../../extension/util.dart';
import '../../../../main.dart';
import '../../../util/exports_widget.dart';

part 'widget/item_widget.dart';

part 'widget/list_view_widget.dart';

/// Main screen with list all registered items
class MainScreen extends StatelessWidget {
  /// Default screen
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductListState>(
      create: (_) => ProductListState(),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

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
