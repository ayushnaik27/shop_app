import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/main_screen.dart';
import './providers/products_provider.dart';
import '../providers/cart_provider.dart';
import '../screens/product_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        home: MyHomePage(),
        theme:
            ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.pink)),
        routes: {
          ProductDetailPage().routeName: (context) {
            return ProductDetailPage();
          },
        },
      ),
    );
  }
}
