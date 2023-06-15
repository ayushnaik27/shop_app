import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screens/edit_products_screen.dart';

class UserProductsItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductsItem(this.title, this.imageUrl, this.id);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        trailing: Container(
          width: 100,
          child: Row(children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductsScreen.routeName, arguments: id);
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () async {
                try {
                  Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  scaffold.showBottomSheet(
                    (context) {
                      return Text('deleting failed');
                    },
                  );
                }
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
