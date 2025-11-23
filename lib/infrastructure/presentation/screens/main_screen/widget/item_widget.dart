part of '../main_screen.dart';

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({required this.item});

  final CloseProductsModel item;

  @override
  Widget build(BuildContext context) {
    final cardContainer = colorDefault.mainColor;

    return ExpansionTile(
      collapsedBackgroundColor: cardContainer,
      backgroundColor: cardContainer,
      title: Text(
        item.title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      children: [
        for (final item in item.items)
          _ItemWidget2(
            item: item,
          ),
      ],
    );
  }
}

class _ItemWidget2 extends StatelessWidget {
  const _ItemWidget2({required this.item});

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    final cardContainer = colorDefault.secondColor;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteDefault.formScreen);
      },
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantidade: ${item.quantity}'),
                        Text('${item.createdHour}'),
                      ],
                    ),
                    Text('Modelo: ${item.model} - ${item.code}'),
                    Text('Valor: ${item.value}'),
                    Text('Valor total: ${item.totalValue ?? ''}'),
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

    final radiusDefault = const Radius.circular(4);

    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: backGroundColor,
            child: Text(
              day ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
