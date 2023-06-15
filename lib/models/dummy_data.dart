import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Item with ChangeNotifier {
  var id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  final int quantity;
  bool isFavourite;

  Item({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.quantity,
    this.isFavourite = false,
  });

  Future<void> favouriteToggle() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    final url = Uri.parse(
        'https://flutter-shop-app-51776-default-rtdb.firebaseio.com/products/$id.json');
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavourite': isFavourite,
          }));
          if(response.statusCode>=400){
            isFavourite= oldStatus;
            notifyListeners();
          }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
