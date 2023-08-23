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
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'TitleFont',
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  height: 2,
                  color: Colors.grey[300],
                ),
                InkWell(
                  onTap: () {

                  },
                  child: Text(
                    'Autheur: $author',
                    style: TextStyle(
                      fontSize: 21,
                      decoration: TextDecoration.underline,
                      letterSpacing: 1,
                      color: Color.fromRGBO(207, 238, 247, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("$path", style: TextStyle(fontSize: 17, color: Colors.grey,fontFamily: "monospace")),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Créer le:\n ${DateFormat('dd/MM/yyyy').format(creationDate!.toDate())}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      'dernière édition:\n ${DateFormat('dd/MM/yyyy').format(lastEditDate!.toDate())}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  height: 2,
                  color: Colors.grey[300],
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
                          Icon(Icons.thumb_up, color: Colors.green, size: 30),
                          SizedBox(width: 4),
                          Text('$upVotes', style: TextStyle(fontSize: 22)),
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
                          Icon(Icons.thumb_down, color: Colors.red, size: 30),
                          SizedBox(width: 4),
                          Text('$downVotes', style: TextStyle(fontSize: 22)),
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
                          Text('More Details', style: TextStyle(fontSize: 18)),
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