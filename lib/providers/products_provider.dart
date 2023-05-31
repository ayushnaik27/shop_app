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
      isFavourite: false,
    ),
    Item(
      id: "2",
      title: "KitKat",
      price: 8.99,
      description: "Crunchy wafer chocolate bar",
      imageUrl: "https://m.media-amazon.com/images/I/51xW9xPBN3L._SX522_.jpg",
      quantity: 30,
      isFavourite: false,
    ),
    Item(
      id: "3",
      title: "Twix",
      price: 9.99,
      description: "Caramel and cookie chocolate bar",
      imageUrl: "https://m.media-amazon.com/images/I/5174rfQNeIL._SX466_.jpg",
      quantity: 25,
      isFavourite: false,
    ),
    Item(
      id: "4",
      title: "5-star",
      price: 7.99,
      description: "Rich and smooth chocolate bar",
      imageUrl: "https://m.media-amazon.com/images/I/618fySthK8L._SX522_.jpg",
      quantity: 40,
      isFavourite: false,
    ),
    Item(
      id: "5",
      title: "Oreo",
      price: 5.99,
      description: "Chocolate sandwich cookies",
      imageUrl: "https://m.media-amazon.com/images/I/61-pXsfgjTS._SL1500_.jpg",
      quantity: 60,
      isFavourite: false,
    ),
    Item(
      id: "6",
      title: "Hide & seek",
      price: 6.99,
      description: "Crunchy chocolate chip cookies",
      imageUrl: "https://m.media-amazon.com/images/I/61OZQN4AQ5L._SL1200_.jpg",
      quantity: 35,
      isFavourite: false,
    ),
    Item(
      id: "7",
      title: "Dark fantasy",
      price: 8.99,
      description: "Rich and indulgent chocolate cookies",
      imageUrl: "https://m.media-amazon.com/images/I/81gzAVquhUL._SL1500_.jpg",
      quantity: 45,
      isFavourite: false,
    ),
    Item(
      id: "8",
      title: "Lottle pie",
      price: 12.99,
      description: "Delicious fruit-filled mini pies",
      imageUrl: "https://m.media-amazon.com/images/I/51sAiup+ppL.jpg",
      quantity: 20,
      isFavourite: false,
    ),
    Item(
      id: "9",
      title: "Pen",
      price: 1.99,
      description: "Blue ballpoint pen",
      imageUrl:
          "https://www.bigbasket.com/media/uploads/p/l/40290249_1-uni-ball-click-gel-pen-blue-ink.jpg",
      quantity: 100,
      isFavourite: false,
    ),
    Item(
      id: "10",
      title: "Pencil",
      price: 0.99,
      description: "Wooden graphite pencil",
      imageUrl:
          "https://4.imimg.com/data4/PL/IY/MY-23695144/natraj-pencil-500x500.jpg",
      quantity: 80,
      isFavourite: false,
    ),
    Item(
      id: "11",
      title: "Scale",
      price: 2.99,
      description: "Plastic ruler",
      imageUrl:
          "https://www.elecmatics.com/wp-content/uploads/2017/12/plastic-ruler-1.jpg",
      quantity: 50,
      isFavourite: false,
    ),
    Item(
      id: "12",
      title: "Toothpaste",
      price: 4.99,
      description: "Mint-flavored toothpaste",
      imageUrl: "https://m.media-amazon.com/images/I/61nctAojOEL._SX679_.jpg",
      quantity: 30,
      isFavourite: false,
    ),
    Item(
      id: "13",
      title: "Brush",
      price: 3.99,
      description: "Soft-bristle toothbrush",
      imageUrl:
          "https://www.bigbasket.com/media/uploads/p/l/40000369_8-colgate-zigzag-medium-bristle-toothbrush.jpg",
      quantity: 40,
      isFavourite: false,
    ),
    Item(
      id: "14",
      title: "Bodywash",
      price: 7.99,
      description: "Refreshing body wash",
      imageUrl: "https://m.media-amazon.com/images/I/419w4PBH11L._SL1000_.jpg",
      quantity: 25,
      isFavourite: false,
    ),
    Item(
      id: "15",
      title: "Facewash",
      price: 6.99,
      description: "Gentle facial cleanser",
      imageUrl: "https://m.media-amazon.com/images/I/51S1xnq72ML._SL1000_.jpg",
      quantity: 30,
      isFavourite: false,
    ),
    Item(
      id: "16",
      title: "Loofah",
      price: 2.99,
      description: "Exfoliating bath sponge",
      imageUrl:
          "https://5.imimg.com/data5/WA/TU/MY-18958697/loofah-sponge-500x500.jpg",
      quantity: 50,
      isFavourite: false,
    ),
    Item(
      id: "17",
      title: "Shampoo",
      price: 9.99,
      description: "Nourishing hair shampoo",
      imageUrl: "https://m.media-amazon.com/images/I/61ZrPaeTcfL._SL1500_.jpg",
      quantity: 30,
      isFavourite: false,
    ),
    Item(
      id: "18",
      title: "Conditioner",
      price: 9.99,
      description: "Hydrating hair conditioner",
      imageUrl: "https://m.media-amazon.com/images/I/41Gi2qS7zYL._SY355_.jpg",
      quantity: 30,
      isFavourite: false,
    ),
    Item(
      id: "19",
      title: "Hair pins",
      price: 1.99,
      description: "Set of hair pins",
      imageUrl: "https://m.media-amazon.com/images/I/418+Gqn2BeL.jpg",
      quantity: 50,
      isFavourite: false,
    ),
    Item(
      id: "20",
      title: "Tops",
      price: 19.99,
      description: "Women's casual top",
      imageUrl:
          "https://5.imimg.com/data5/SELLER/Default/2022/1/US/AN/IE/2985467/tops-500x500.jpg",
      quantity: 15,
      isFavourite: false,
    ),
    Item(
      id: "21",
      title: "Pyjamas",
      price: 15.99,
      description: "Comfortable sleepwear",
      imageUrl:
          "https://assets.ajio.com/medias/sys_master/root/20221117/3mjP/6375d7a1f997ddfdbd7fc9fe/-473Wx593H-441205437-blue-MODEL.jpg",
      quantity: 20,
      isFavourite: false,
    ),
    Item(
      id: "22",
      title: "Kurti",
      price: 24.99,
      description: "Traditional Indian women's attire",
      imageUrl:
          "https://www.arihantfashion.com/wp-content/uploads/2022/03/designer-anarkali-kurti-with-pant-6.jpg",
      quantity: 10,
      isFavourite: false,
    ),
    Item(
      id: "23",
      title: "Plazo",
      price: 18.99,
      description: "Wide-legged trousers",
      imageUrl:
          "https://5.imimg.com/data5/PQ/DN/MU/SELLER-24927440/bottom-print-plazo-1000x1000.jpg",
      quantity: 15,
      isFavourite: false,
    ),
    Item(
      id: "24",
      title: "Bournvita",
      price: 11.99,
      description: "Health drink mix",
      imageUrl: "https://m.media-amazon.com/images/I/6113jMzM0CL._SL1500_.jpg",
      quantity: 40,
      isFavourite: false,
    ),
    Item(
      id: "25",
      title: "Nutella",
      price: 8.99,
      description: "Hazelnut spread",
      imageUrl: "https://m.media-amazon.com/images/I/71WDhp2+GUL._SL1500_.jpg",
      quantity: 30,
      isFavourite: false,
    ),
    Item(
      id: "26",
      title: "Jam",
      price: 5.99,
      description: "Fruit jam",
      imageUrl: "https://m.media-amazon.com/images/I/51NJJNAATTL._SX522_.jpg",
      quantity: 35,
      isFavourite: false,
    ),
    Item(
      id: "27",
      title: "Bread",
      price: 3.99,
      description: "White bread loaf",
      imageUrl:
          "https://c8.alamy.com/comp/BH1650/studio-cut-out-on-white-isolate-loaf-of-hovis-sliced-white-bread-in-BH1650.jpg",
      quantity: 40,
      isFavourite: false,
    ),
    Item(
      id: "28",
      title: "Bag",
      price: 29.99,
      description: "Stylish backpack",
      imageUrl: "https://m.media-amazon.com/images/I/61iR9NMcKpL._UX569_.jpg",
      quantity: 10,
      isFavourite: false,
    ),
    Item(
      id: "29",
      title: "Shoes",
      price: 39.99,
      description: "Running shoes",
      imageUrl:
          "https://m.media-amazon.com/images/I/51uVlUdW3BL._AC._SR360,460.jpg",
      quantity: 8,
      isFavourite: false,
    ),
    Item(
      id: "30",
      title: "Chappal",
      price: 14.99,
      description: "Casual sandals",
      imageUrl:
          "https://admin.walkwayshoes.com/product/57-4956/1080/57-4956M24.jpg",
      quantity: 12,
      isFavourite: false,
    ),
    Item(
      id: "31",
      title: "Perfume",
      price: 29.99,
      description: "Fragrance for men",
      imageUrl: "https://m.media-amazon.com/images/I/71CJ6MrX-+L._SL1500_.jpg",
      quantity: 20,
      isFavourite: false,
    ),
  ];

  List<Item> get items {
    return [..._items];
  }

  Item findById(String id) {
    return _items.firstWhere((element) => element == id);
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
