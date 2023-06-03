import 'package:flutter/material.dart';

import 'cart_provider.dart';

class OrderItem {
  final String id;
  final DateTime time;
  final double amount;
  final List<CartItem> cartitem;

  OrderItem({
    required this.amount,
    required this.cartitem,
    required this.id,
    required this.time,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItem, double total) {
    _orders.insert(
      0,
      OrderItem(
        amount: total,
        cartitem: cartItem,
        id: DateTime.now().toString(),
        time: DateTime.now(),
      ),
    );
  }
}
