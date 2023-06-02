// List<Item> items = [
  
// ];

import 'package:flutter/material.dart';

class Item with ChangeNotifier {
  
  final String id;
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

  

  void favouriteToggle(){
    isFavourite=!isFavourite;
    notifyListeners();
  }
}
