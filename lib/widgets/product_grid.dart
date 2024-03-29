import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;

  const ProductGrid(this.showFavs, {super.key});
  @override
  Widget build(BuildContext context) {
    final itemsData = Provider.of<Products>(context);

    final items = showFavs ? itemsData.favItems : itemsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: items[index],
          child: ProductItem(),
        );
      },
    );
  }
}
