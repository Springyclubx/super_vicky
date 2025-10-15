part of '../main_screen.dart';

class _ListViewWidget extends StatelessWidget {
  const _ListViewWidget();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductListState>(context);

    if (state.items.isEmpty) {
      return const Text('data');
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ListView.separated(
        itemCount: state.items.length,
        separatorBuilder: (context, index) {
          return const Divider(height: 2, thickness: 2);
        },
        itemBuilder: (context, index) {
          final item = state.items[index];

          return _ItemWidget(item: item);
        },
      ),
    );
  }
}
