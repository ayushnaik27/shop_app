import 'package:flutter/material.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = '/edit-products';

  @override
  State<EditProductsScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: ListView(children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Title'),
            )
          ]),
        ),
      ),
    );
  }
}
