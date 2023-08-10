import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import '../models/dummy_data.dart';

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
    this.isFavourite=false,
  });
}

class Products with ChangeNotifier {
  final String authToken;
  final String userId;

  List<Item> _items = [
    // Item(
    //   id: "1",
    //   title: "Diary milk",
    //   price: 10.99,
    //   description: "Delicious milk chocolate",
    //   imageUrl:
    //       "https://5.imimg.com/data5/SELLER/Default/2023/2/DZ/YH/EC/15355181/prod-20211227-1807503220564475383400315-jpg-500x500.jpg",
    //   quantity: 50,
    // ),
    // Item(
    //   id: "2",
    //   title: "KitKat",
    //   price: 8.99,
    //   description: "Crunchy wafer chocolate bar",
    //   imageUrl: "https://m.media-amazon.com/images/I/51xW9xPBN3L._SX522_.jpg",
    //   quantity: 30,
    // ),
    // Item(
    //   id: "3",
    //   title: "Twix",
    //   price: 9.99,
    //   description: "Caramel and cookie chocolate bar",
    //   imageUrl: "https://m.media-amazon.com/images/I/5174rfQNeIL._SX466_.jpg",
    //   quantity: 25,
    // ),
    // Item(
    //   id: "4",
    //   title: "5-star",
    //   price: 7.99,
    //   description: "Rich and smooth chocolate bar",
    //   imageUrl: "https://m.media-amazon.com/images/I/618fySthK8L._SX522_.jpg",
    //   quantity: 40,
    // ),
    // Item(
    //   id: "5",
    //   title: "Oreo",
    //   price: 5.99,
    //   description: "Chocolate sandwich cookies",
    //   imageUrl: "https://m.media-amazon.com/images/I/61-pXsfgjTS._SL1500_.jpg",
    //   quantity: 60,
    // ),
    // Item(
    //   id: "6",
    //   title: "Hide & seek",
    //   price: 6.99,
    //   description: "Crunchy chocolate chip cookies",
    //   imageUrl: "https://m.media-amazon.com/images/I/61OZQN4AQ5L._SL1200_.jpg",
    //   quantity: 35,
    // ),
    // Item(
    //   id: "7",
    //   title: "Dark fantasy",
    //   price: 8.99,
    //   description: "Rich and indulgent chocolate cookies",
    //   imageUrl: "https://m.media-amazon.com/images/I/81gzAVquhUL._SL1500_.jpg",
    //   quantity: 45,
    // ),
    // Item(
    //   id: "8",
    //   title: "Lottle pie",
    //   price: 12.99,
    //   description: "Delicious fruit-filled mini pies",
    //   imageUrl: "https://m.media-amazon.com/images/I/51sAiup+ppL.jpg",
    //   quantity: 20,
    // ),
  ];

  Products(this.authToken, this._items, this.userId);

  List<Item> get favItems {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  List<Item> get items {
    return [..._items];
  }

  Item findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  bool isFavourite(String id) {
    final Item item = _items.firstWhere((element) => element.id == id);
    if (item.isFavourite) return true;

    return false;
  }

  Future<void> fetchAndSetProduct([bool filterByUser = false]) async {
    final String filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

    final url = Uri.parse(
        'https://flutter-shop-app-51776-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      final List<Item> loadedProducts = [];
      // print(json.decode(response.body));

      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Item(
            id: prodId,
            title: prodData['title'],
            price: prodData['price'],
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            quantity: prodData['quantity'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Item product) async {
    final url = Uri.parse(
        'https://flutter-shop-app-51776-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'quantity': product.quantity,
          'creatorId': userId,
        }),
      );

      // print(json.decode(response.body));
      final newProduct = Item(
        description: product.description,
        id: json.decode(response.body)['name'],
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
        quantity: 1,
      );
      _items.add(newProduct);
      print(newProduct.id);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Item newproduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    final url = Uri.parse(
        'https://flutter-shop-app-51776-default-rtdb.firebaseio.com/products/$id.json');

    await http.patch(url,
        body: json.encode({
          'title': newproduct.title,
          'price': newproduct.price,
          'imageUrl': newproduct.imageUrl,
          'description': newproduct.description,
        }));

    if (prodIndex >= 0) {
      _items[prodIndex] = newproduct;
      notifyListeners();
    }
  }

  // Future<void> favouriteToggle(String id) async {
    
  //   final item = _items.firstWhere((element) => element.id == id);

  //   final oldStatus = item.isFavourite;
  //   item.isFavourite = !item.isFavourite;
  //   notifyListeners();

  //   final url = Uri.parse(
  //       'https://flutter-shop-app-51776-default-rtdb.firebaseio.com/users/$userId.json');
  //   try {
  //     final response = await http.post(url,
  //         body: json.encode({
  //           'isFavourite': isFavourite,
  //         }));
  //         print(response.body);

  //     if (response.statusCode >= 400) {
  //       item.isFavourite = oldStatus;
  //       notifyListeners();
  //     }
  //   } catch (error) {
  //     item.isFavourite = oldStatus;
  //     notifyListeners();
  //   }
  // }

  void favouriteToggle(String id){
    Item item= _items.firstWhere((element) => element.id==id);
    print(item.isFavourite);
    bool oldStatus=item.isFavourite;
    item.isFavourite=!item.isFavourite;
    notifyListeners();
    print(item.isFavourite);

  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://flutter-shop-app-51776-default-rtdb.firebaseio.com/products/$id.json');
    final existingProdIndex = _items.indexWhere((element) => element.id == id);
    var existingProd = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProdIndex, existingProd);
      notifyListeners();
      throw const HttpException('Deleting Failed');
    }
    existingProd.dispose();
  }
}
