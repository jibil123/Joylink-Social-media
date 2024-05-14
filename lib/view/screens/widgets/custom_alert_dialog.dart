import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onOkPressed;
  final String childName;
  const CustomAlertDialog({super.key, required this.title, required this.message, required this.onOkPressed, required this.childName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text(childName),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            onOkPressed(); // Call the provided callback
          },
        ),
      ],
    );
  }
}
