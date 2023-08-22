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
    return Card(
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
                    fontFamily: 'TitleFont',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  height: 1,
                  color: Colors.grey[300],
                ),
                InkWell(
                  onTap: () {
                    // Navigate to author's profile or perform related action
                  },
                  child: Text(
                    'Author: $author',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue, // Change the author's name color
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text('Path: $path', style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Created At: ${DateFormat('dd/MM/yyyy').format(creationDate)}',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      'Last Edit: ${DateFormat('dd/MM/yyyy').format(lastEditDate)}',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Perform upvote action
                      },
                      child: Row(
                        children: [
                          Icon(Icons.thumb_up, color: Colors.green, size: 20),
                          SizedBox(width: 4),
                          Text('$upVotes', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    InkWell(
                      onTap: () {
                        // Perform downvote action
                      },
                      child: Row(
                        children: [
                          Icon(Icons.thumb_down, color: Colors.red, size: 20),
                          SizedBox(width: 4),
                          Text('$downVotes', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        // Navigate to the proposition page
                      },
                      child: Row(
                        children: [
                          Icon(Icons.more_horiz, size: 24), // Use a more descriptive icon
                          SizedBox(width: 4),
                          Text('More Details', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
        ],
      ),
    );
  }
}
