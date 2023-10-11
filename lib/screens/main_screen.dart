
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/shimmer.dart';

import '../providers/products_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';

enum FilterOptions {
  favourites,
  all,
}

class MyHomePage extends StatefulWidget {
  static const routeName = '/';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showFavourites = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('My Shop'),
        // backgroundColor: Colors.pink,
        actions: [
          PopupMenuButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favourites,//0
                child: Text('Only Favourites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,//1
                child: Text('All Items'),
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
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartPage.routeName);
                },
                icon: const Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      body: _isLoading
          ? const HomeShimmer()
          : ProductGrid(showFavourites),
    );
  }
}


