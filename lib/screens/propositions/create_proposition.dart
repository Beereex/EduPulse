import 'package:flutter/material.dart';

class CreateProposition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer Proposition'),
      ),
      body: Center(
        child: Text(
          'Create Proposition Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
