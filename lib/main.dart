import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/providers/order_provider.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import 'screens/cart_screen.dart';

import 'screens/main_screen.dart';
import './providers/products_provider.dart';
import '../providers/cart_provider.dart';
import '../screens/product_detail_screen.dart';
import './screens/orders_screen.dart';
import './screens/edit_products_screen.dart';
import './screens/auth_screen.dart';

void main() {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth,Products>(
            update: (context, auth, previous) => Products(auth.token.toString(), previous==null? []:previous.items,auth.userId.toString()),
            create: (context) => Products('',[],''),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (context) => Orders(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            home: auth.isAuth ? MyHomePage() : AuthScreen(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(backgroundColor: Colors.pink),
                textTheme:
                    const TextTheme(titleMedium: TextStyle(color: Colors.amber))),
            routes: {
              MyHomePage.routeName: (context) => MyHomePage(),
              ProductDetailPage.routeName: (context) => ProductDetailPage(),
              CartPage.routeName: (context) => CartPage(),
              OrderScreen.routeName: (context) => OrderScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              EditProductsScreen.routeName: (context) => EditProductsScreen(),
            },
          ),
        ));
  }
}
