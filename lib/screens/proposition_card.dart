import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PropositionCard extends StatelessWidget {
  final String title;
  final String author;
  final String path;
  final DateTime creationDate;
  final DateTime lastEditDate;
  final int upVotes;
  final int downVotes;

  PropositionCard({
    required this.title,
    required this.author,
    required this.path,
    required this.creationDate,
    required this.lastEditDate,
    required this.upVotes,
    required this.downVotes,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the proposition page using Navigator
      },
      child: Card(
        elevation: 1,
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'TitleFont', // Change font family for title
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 1, // Height of the separating line
                    color: Colors.grey[300], // Light separating line color
                  ),
                  Text('Author: $author', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 4),
                  Text(
                    'Creation Date: ${DateFormat('dd/MM/yyyy').format(creationDate)}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    'Last Edit Date: ${DateFormat('dd/MM/yyyy').format(lastEditDate)}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.thumb_up, color: Colors.green, size: 20),
                            SizedBox(width: 4),
                            Text('$upVotes', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('|', style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.thumb_down, color: Colors.red, size: 20),
                            SizedBox(width: 4),
                            Text('$downVotes', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey[300]), // Subtle bottom border
          ],
        ),
      ),
    );
  }
}
