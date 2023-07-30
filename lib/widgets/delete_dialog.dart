import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you really want to delete an item?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              
            },
            child: const Text('Yes')),
      ],
    );
  }
}
