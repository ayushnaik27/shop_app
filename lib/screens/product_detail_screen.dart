import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailPage extends StatelessWidget {
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Column(children: [
        Container(
          height: 300,
          width: double.infinity,
          child: Image.network(
            loadedProduct.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            loadedProduct.title,
            style: TextStyle(color: Colors.amber, fontSize: 30),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            loadedProduct.description,
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            '₹${loadedProduct.price}',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
      ]),
    );
  }
}
