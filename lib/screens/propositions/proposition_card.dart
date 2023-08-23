import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/proposition.dart';

class PropositionCard extends StatelessWidget {
  final Proposition proposition;
  String? title;
  String? author;
  String? path;
  Timestamp? creationDate;
  Timestamp? lastEditDate;
  int? upVotes;
  int? downVotes;

  PropositionCard({required this.proposition}) {
    this.title = proposition.title;
    this.author = proposition.authorName;
    this.path = proposition.getPath();
    this.creationDate = proposition.creationDate;
    this.lastEditDate = proposition.lastEditDate;
    this.upVotes = proposition.upvoteCount;
    this.downVotes = proposition.downvoteCount;
  }

  /*PropositionCard({
    required this.title,
    required this.author,
    required this.path,
    required this.creationDate,
    required this.lastEditDate,
    required this.upVotes,
    required this.downVotes,
  });

  PropositionCard.fromProposition(Proposition proposition)
      : title = proposition.title!,
        author = proposition.authorId!,
        path = proposition.getPath(),
        creationDate = proposition.creationDate!,
        lastEditDate = proposition.lastEditDate!,
        upVotes = proposition.upvoteCount!,
        downVotes = proposition.downvoteCount!;

   */

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
                  title!,
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
                      'Created At: ${DateFormat('dd/MM/yyyy').format(creationDate!.toDate())}',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      'Last Edit: ${DateFormat('dd/MM/yyyy').format(lastEditDate!.toDate())}',
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