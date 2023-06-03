import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String prodId;

  CartItem(
      {required this.id,
      required this.prodId,
      required this.price,
      required this.quantity,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(prodId),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(child: Text('₹$price'))),
            ),
            title: Text(title),
            subtitle: Text('₹${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white70),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeItem(prodId);
      },
    );
  }
}
