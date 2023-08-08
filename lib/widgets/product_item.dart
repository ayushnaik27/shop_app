import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/screens/product_detail_screen.dart';

import '../models/dummy_data.dart';
import '../providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  // final Item item;

  // ProductItem({required this.item});
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(
      context,
      listen: false,
    );
    final cartItem = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Item>(
            builder: (context, value, child) => IconButton(
              icon: Icon(
                  item.isFavourite ? Icons.favorite : Icons.favorite_border),
              onPressed: () async {
                await item.favouriteToggle();
              },
            ),
            // child: Text('Never changes')// Ye aisa child hai consiumer ka jisko hame channge nahi krna hai
          ),
          title: Text(
            item.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              cartItem.addItem(item.id, item.price, item.title);
              Scaffold.of(context).showBottomSheet((context) {
                return const Text('Added item');
              });
            },
          ),
        ),
        child: GestureDetector(
          child: Image.network(item.imageUrl,fit: BoxFit.fitWidth),
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailPage.routeName, arguments: item.id);
          },
        ),
      ),
    );
  }
}
