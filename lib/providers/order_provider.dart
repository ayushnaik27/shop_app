import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final timeStamp = DateTime.now();
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartItems, double total) async {
    final url = Uri.parse(
        'https://flutter-shop-app-51776-default-rtdb.firebaseio.com/orders.json');
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'time': timeStamp.toIso8601String(),
          'cartItem': cartItems
              .map((ci) => {
                    'title': ci.title,
                    'price': ci.price,
                    'quantity': ci.quantity,
                    'id': ci.id
                  })
              .toString(),
        }));
    _orders.insert(
      0,
      OrderItem(
        amount: total,
        cartitem: cartItems,
        id: json.decode(response.body)['name'],
        time: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
