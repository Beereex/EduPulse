import 'package:flutter/material.dart';

class SearchPropositions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rechercher Propositions'),
      ),
      body: Center(
        child: Text(
          'Search Propositions Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
