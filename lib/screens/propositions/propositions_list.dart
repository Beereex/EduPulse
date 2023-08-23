import 'package:edupulse/screens/proposition_card.dart';
import 'package:flutter/material.dart';
import '../../models/proposition.dart';

class SearchPropositions extends StatelessWidget {
  Map<String, Proposition>? propositionsList;
  int fetchLimit = 1;

  /*
  Future<PropositionCard?> getPropositonCard(){
    return PropositionCard(title: title, author: author, path: path, creationDate: creationDate, lastEditDate: lastEditDate, upVotes: upVotes, downVotes: downVotes);
  }

   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Propositions'),
      ),
      body: Column(
        children: [
          _buildSearchFilterSection(),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
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
