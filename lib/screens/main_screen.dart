import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: Colors.white24,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
          height: 70,
          color: Colors.white,
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Categories',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(width: 28),
              Container(
                width: 225,
                height: 40,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromRGBO(248, 223, 243, 100),
                ),
                child: Row(children: [
                  Icon(Icons.search_outlined),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      decoration:
                          InputDecoration(labelText: 'Search Any Product'),
                          
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
