import 'package:flutter/material.dart';

import '../models/dummy_data.dart';

class Products with ChangeNotifier {
  List<Item> _items = [
    Item(
      id: "1",
      title: "Diary milk",
      price: 10.99,
      description: "Delicious milk chocolate",
      imageUrl:
          "https://5.imimg.com/data5/SELLER/Default/2023/2/DZ/YH/EC/15355181/prod-20211227-1807503220564475383400315-jpg-500x500.jpg",
      quantity: 50,
    ),
    Item(
      id: "2",
      title: "KitKat",
      price: 8.99,
      description: "Crunchy wafer chocolate bar",
      imageUrl: "https://m.media-amazon.com/images/I/51xW9xPBN3L._SX522_.jpg",
      quantity: 30,
    ),
    Item(
      id: "3",
      title: "Twix",
      price: 9.99,
      description: "Caramel and cookie chocolate bar",
      imageUrl: "https://m.media-amazon.com/images/I/5174rfQNeIL._SX466_.jpg",
      quantity: 25,
    ),
    Item(
      id: "4",
      title: "5-star",
      price: 7.99,
      description: "Rich and smooth chocolate bar",
      imageUrl: "https://m.media-amazon.com/images/I/618fySthK8L._SX522_.jpg",
      quantity: 40,
    ),
    Item(
      id: "5",
      title: "Oreo",
      price: 5.99,
      description: "Chocolate sandwich cookies",
      imageUrl: "https://m.media-amazon.com/images/I/61-pXsfgjTS._SL1500_.jpg",
      quantity: 60,
    ),
    Item(
      id: "6",
      title: "Hide & seek",
      price: 6.99,
      description: "Crunchy chocolate chip cookies",
      imageUrl: "https://m.media-amazon.com/images/I/61OZQN4AQ5L._SL1200_.jpg",
      quantity: 35,
    ),
    Item(
      id: "7",
      title: "Dark fantasy",
      price: 8.99,
      description: "Rich and indulgent chocolate cookies",
      imageUrl: "https://m.media-amazon.com/images/I/81gzAVquhUL._SL1500_.jpg",
      quantity: 45,
    ),
    Item(
      id: "8",
      title: "Lottle pie",
      price: 12.99,
      description: "Delicious fruit-filled mini pies",
      imageUrl: "https://m.media-amazon.com/images/I/51sAiup+ppL.jpg",
      quantity: 20,
    ),

  ];

  List<Item> get favItems {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  List<Item> get items {
    return [..._items];
  }

  Item findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
