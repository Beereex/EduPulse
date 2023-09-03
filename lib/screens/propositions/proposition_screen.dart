import 'package:flutter/material.dart';
import '../../models/proposition.dart';

class PropositionScreen extends StatelessWidget {
  final Proposition proposition;

  PropositionScreen({required this.proposition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(proposition.title ?? 'Untitled'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proposition.content ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Author: ${proposition.authorName ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Path: ${proposition.path ?? ''}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Upvotes: ${proposition.upvoteCount ?? 0}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Downvotes: ${proposition.downvoteCount ?? 0}',
                    style: TextStyle(fontSize: 16),
                  ),
                  // Add more fields as needed
                ],
              ),
            ),
          ),
          // ...
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 1,
            snap: true,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color: Colors.grey[800], // Dark background color
                child: ListView(
                  controller: scrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Comment Section',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '10 Comments', // Placeholder for the number of comments
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    // Simulate message cards with ListView.builder
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // Prevent nested ListView from scrolling
                      itemCount: 10, // Number of message cards
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.grey[900], // Dark card color
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Message ${index + 1}', // Placeholder for the message
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Author Name', // Placeholder for author
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Creation Date', // Placeholder for creation date
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Last Edit Date', // Placeholder for last edit date
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
