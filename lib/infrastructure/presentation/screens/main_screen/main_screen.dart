import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_vicky/domain/entities/product_model.dart';
import 'package:super_vicky/extension/string_util.dart';
import 'package:super_vicky/infrastructure/presentation/states/product_list_state.dart';

import '../../../../extension/util.dart';
import '../../../../main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductListState>(
      create: (_) => ProductListState(),
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductListState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Guigas', style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: _ListViewWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class _ListViewWidget extends StatelessWidget {
  const _ListViewWidget();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductListState>(context);

    if (state.items.isEmpty) {
      return Text('data');
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ListView.separated(
        itemCount: state.items.length,
        separatorBuilder: (context, index) {
          return Divider(height: 2, thickness: 2);
        },
        itemBuilder: (context, index) {
          final item = state.items[index];

          return _ItemWidget(item: item);
        },
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({required this.item});

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    final cardContainer = colorDefault.secondColor;

    return InkWell(
      onTap: () {},
      child: Container(
        color: cardContainer.withValues(alpha: 0.8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: _MonthItem(item: item),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('date: ${item.date.toString()}'),
                    Text('model: ${item.model}'),
                    Text('code: ${item.code}'),
                    Text('quantity: ${item.quantity.toString()}'),
                    Text('value: ${item.value.toString()}'),
                    Text('totalValue: ${item.totalValue.toString()}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MonthItem extends StatelessWidget {
  const _MonthItem({required this.item});

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    final month = tryFormatDate('MMMM', item.date)?.uppercaseFirst();
    final day = tryFormatDate('dd', item.date);

    final cardColor = Theme.of(context).cardColor;
    final backGroundColor = colorDefault.backGroundColor;

    final radiusDefault = Radius.circular(4);

    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.only(
                topLeft: radiusDefault,
                topRight: radiusDefault,
              ),
            ),
            child: Text(month ?? ''),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: backGroundColor,
            child: Text(
              day ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.only(
                bottomLeft: radiusDefault,
                bottomRight: radiusDefault,
              ),
            ),
            height: 8,
          ),
        ],
      ),
    );
  }
}
