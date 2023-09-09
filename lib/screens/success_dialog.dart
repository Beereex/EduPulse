import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String message;

  SuccessDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sauvegarde Réussie'), // Title in French
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
