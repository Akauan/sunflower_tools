import 'package:flutter/material.dart';

class ItemListComponent<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final Future<void> Function() onRefresh;

  const ItemListComponent({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Material(
              borderRadius: BorderRadius.zero,
              clipBehavior: Clip.antiAlias,
              child: itemBuilder(items[index]),
            ),
          );
        },
      ),
    );
  }
}
