import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/screens/product_detail_screen.dart';

import '../models/dummy_data.dart';

class ProductItem extends StatelessWidget {
    // final Item item;

    // ProductItem({required this.item});
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);


    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(item.imageUrl),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return ProductDetailPage();
            }));
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon:
                Icon(item.isFavourite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              item.favouriteToggle();
            },
          ),
          title: Text(
            item.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
