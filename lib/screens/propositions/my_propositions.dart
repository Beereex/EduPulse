import 'package:flutter/material.dart';

class MyPropositions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Propositions'),
      ),
      body: Center(
        child: Text(
          'My Propositions Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
