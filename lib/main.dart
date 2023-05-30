import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import 'screens/main_screen.dart';
import './providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (context) => Products(),
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
