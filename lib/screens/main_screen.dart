import 'package:flutter/material.dart';
import 'package:shop_app/screens/settings_screen.dart';


import '../widgets/product_grid.dart';


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            color: Colors.pink.shade400,
          ),
          SizedBox(height: 30),
          drawer_item(Icons.production_quantity_limits_outlined, 'All Items',context),
          drawer_item(Icons.settings_accessibility_rounded, 'Settings',context),
        ],
      )),
      appBar: AppBar(
        title: Text('Shop Ki List'),
        backgroundColor: Colors.pink,
      ),
      body: ProductGrid(),
    );
  }

  Widget drawer_item(final IconData icon, final String title, final BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx ) {
           if(title == 'All Items') return MyHomePage();
           else return SettingsPage();
        } ));
      },
      child: Container(
        margin: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 10,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}




