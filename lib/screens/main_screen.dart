import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

import '../screens/settings_screen.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';

enum FilterOptions {
  favourites,
  all,
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            color: Colors.pink.shade400,
          ),
          const SizedBox(height: 30),
          drawer_item(
              Icons.production_quantity_limits_outlined, 'All Items', context),
          drawer_item(
              Icons.settings_accessibility_rounded, 'Settings', context),
        ],
      )),
      appBar: AppBar(
        title: Text('Shop Ki List'),
        backgroundColor: Colors.pink,
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.favourites,
              ),
              PopupMenuItem(
                child: Text('All Items'),
                value: FilterOptions.all,
              )
            ],
            onSelected: (value) {
              setState(() {
                if (value == FilterOptions.all) {
                  showFavourites = false;
                } else {
                  showFavourites = true;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) => BadgeCircle(
              color: Colors.orange,
              value: cart.itemCount.toString(),
              child: ch as Widget,
            ),
            child:
                IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      body: ProductGrid(showFavourites),
    );
  }

  Widget drawer_item(
      final IconData icon, final String title, final BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
          if (title == 'All Items')
            return MyHomePage();
          else
            return SettingsPage();
        }));
      },
      child: Container(
        margin: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 10,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
