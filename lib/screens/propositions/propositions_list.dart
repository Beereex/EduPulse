import 'package:edupulse/screens/proposition_card.dart';
import 'package:flutter/material.dart';

class SearchPropositions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Propositions'),
      ),
      body: Column(
        children: [
          _buildSearchFilterSection(), // Add this line for the search and filter section
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Number of PropositionCard widgets
              itemBuilder: (context, index) {
                return PropositionCard(
                  title: "title",
                  author: "author",
                  path: "path",
                  creationDate: DateTime.parse("2023-08-01"),
                  lastEditDate: DateTime.parse("2023-08-01"),
                  upVotes: 0,
                  downVotes: 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFilterSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Filter and Search Options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Option 1'),
          Text('Option 2'),
          Text('Option 3'),
          // Add more options as needed
        ],
      ),
    );
  }
}
