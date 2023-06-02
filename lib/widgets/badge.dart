import 'package:flutter/material.dart';

class BadgeCircle extends StatelessWidget {
  BadgeCircle({required this.child, required this.color, required this.value});

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.orange),
            // color: Colors.orange,
            constraints: BoxConstraints(
              maxHeight: 16,
              maxWidth: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
          ),
        )
      ],
    );
  }
}
