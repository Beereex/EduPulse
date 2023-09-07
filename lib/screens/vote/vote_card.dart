import 'package:edupulse/models/vote.dart';
import 'package:flutter/material.dart';

class VoteCard extends StatefulWidget {
  Vote vote;
  VoteCard({
    required this.vote,
      });


  @override
  State<VoteCard> createState() => _VoteCardState();
}

class _VoteCardState extends State<VoteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.vote.propositionTitle,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'helvetica',
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          "SpaceHolder",
                          style: TextStyle(fontSize: 15,letterSpacing: 1,height: 1.2),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  height: 1,
                  color: Colors.grey[300],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,8.0,0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/default_profile_pic.jpg'),
                          ),
                        ),
                        Text("SpaceHolder",style: TextStyle(fontSize: 15),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
