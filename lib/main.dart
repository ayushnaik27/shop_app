

import 'package:flutter/material.dart';
import 'package:shop_app/screens/main_screen.dart';

import './dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: [
          Container(
            height: 15,
            width: double.infinity,
            color: Colors.pink.shade400,
          ),
          drawer_item(Icons.production_quantity_limits_outlined, 'All Items'),
          drawer_item(Icons.settings_accessibility_rounded, 'Settings'),
        ],
      )),
      appBar: AppBar(
        title: Text('Shop Ki List'),
        backgroundColor: Colors.pink,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GridTile(
            child: Image.network(items[index].imageUrl),

            
            
          );
        },
      ),
    );
  }

  Container drawer_item(final IconData icon, final String title) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
    );
  }
}
