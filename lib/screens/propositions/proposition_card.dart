import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/screens/propositions/proposition_screen.dart';
import 'package:edupulse/services/app_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/proposition.dart';

class PropositionCard extends StatefulWidget {
  final Proposition proposition;

  PropositionCard({required this.proposition});

  @override
  _PropositionCardState createState() => _PropositionCardState();

}
class _PropositionCardState extends State<PropositionCard>{
  String title = "";
  String author = "";
  String path = "";
  Timestamp creationDate = Timestamp.now();
  Timestamp lastEditDate = Timestamp.now();
  int upVotes = 0;
  int downVotes = 0;
  int userVote = 0;
  Color upSelectionColor = Colors.transparent;
  Color downSelectionColor = Colors.transparent;
  Color upSelectedColor = Colors.green.shade600.withOpacity(0.2);
  Color downSelectedColor = Colors.red.shade600.withOpacity(0.2);

  @override
  void initState(){
    super.initState();
    this.title = widget.proposition.title ?? "Undefined";
    this.author = widget.proposition.authorName ?? "Undefined";
    this.path = widget.proposition.path ?? "Undefined";
    this.creationDate = widget.proposition.creationDate ?? Timestamp.now();
    this.lastEditDate = widget.proposition.lastEditDate ?? Timestamp.now();
    this.upVotes = widget.proposition.upvoteCount ?? 0;
    this.downVotes = widget.proposition.downvoteCount ?? 0;
    this.userVote = widget.proposition.userVoteStatus ?? 0;
    if(userVote == 1){
      upSelectionColor = upSelectedColor;
    }
    else if(userVote == -1){
      downSelectionColor = downSelectedColor;
    }
    else print("userVote not initialized");
  }

  Future<void> _addVote(int voteType) async{
    try{
      await FirebaseFirestore.instance.collection("users").doc(AppData.instance.userInfos!.uid)
          .collection("votes").doc(widget.proposition.id).set({
        "vote": voteType,
        "voteDate": Timestamp.now(),
      });
      print("vote successfuly added");
    }
    catch(e){
      print("Error adding a new vote: $e");
    }
  }

  Future<void> _updateVote(int voteType) async{
    try{
      await FirebaseFirestore.instance.collection("users").doc(AppData.instance.userInfos!.uid)
          .collection("votes").doc(widget.proposition.id).update({
        "vote" : voteType,
        "voteDate" : Timestamp.now(),
      });
      print("vote updated successfully");
    }
    catch(e){
      print("Error updating the vote: $e");
    }
  }

  Future<void> _removeVote() async{
    try{
      await FirebaseFirestore.instance.collection("users").doc(AppData.instance.userInfos!.uid)
          .collection("votes").doc(widget.proposition.id).delete();
      print("vote Deleted successfully");
    }
    catch(e){
      print("Error remoing the vote: $e");
    }
  }

  Future<void> _changedownVotesCounter(int value) async{
    try{
      final propDoc = await FirebaseFirestore.instance.collection("propositions")
          .doc(widget.proposition.id).get();
      if(propDoc.exists){
        Map<String, dynamic> votes = propDoc.data()!;
        int vote = votes["downVotes"] as int ?? 1000;
        vote += value;
        await FirebaseFirestore.instance.collection("propositions")
            .doc(widget.proposition.id).update({
          "downVotes" : vote,
        });
        print("downVote changed successfully");
      }else{
        print("Error changin downVote");
      }
    }
    catch(e){
      print("Error updating vote: $e");
    }
  }

  Future<void> _changeUpVotesCounter(int value) async{
    try{
      final propDoc = await FirebaseFirestore.instance.collection("propositions")
          .doc(widget.proposition.id).get();
      if(propDoc.exists){
        Map<String, dynamic> votes = propDoc.data()!;
        int vote = votes["upVotes"] as int ?? 1000;
        vote += value;
        await FirebaseFirestore.instance.collection("propositions")
            .doc(widget.proposition.id).update({
          "upVotes" : vote,
        });
        print("upVote changed successfully");
      }else{
        print("Error changing upVote");
      }
    }
    catch(e){
      print("Error updating vote: $e");
    }
  }

  void _upVote(){
    if(userVote == 1){
      _changeUpVotesCounter(-1);
      _removeVote();
      setState(() {
        upVotes--;
        userVote = 0;
        upSelectionColor = Colors.transparent;
      });
    }
    else if(userVote == -1){
      _changeUpVotesCounter(1);
      _changedownVotesCounter(-1);
      _updateVote(1);
      setState(() {
        upVotes++;
        downVotes--;
        userVote = 1;
        downSelectionColor = Colors.transparent;
        upSelectionColor = upSelectedColor;
      });
    }
    else{
      _changeUpVotesCounter(1);
      _addVote(1);
      setState(() {
        upVotes++;
        userVote = 1;
        upSelectionColor = upSelectedColor;
      });
    }
  }

  void _downVote(){
    if(userVote == -1){
      _changedownVotesCounter(-1);
      _removeVote();
      setState(() {
        downVotes--;
        userVote = 0;
        downSelectionColor = Colors.transparent;
      });
    }
    else if(userVote == 1){
      _changeUpVotesCounter(-1);
      _changedownVotesCounter(1);
      _updateVote(-1);
      setState(() {
        upVotes--;
        downVotes++;
        userVote = -1;
        downSelectionColor = downSelectedColor;
        upSelectionColor = Colors.transparent;
      });
    }
    else{
      _changedownVotesCounter(1);
      _addVote(-1);
      setState(() {
        downVotes++;
        userVote = -1;
        downSelectionColor = downSelectedColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$path",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade600,
                    fontFamily: "monospace",
                    backgroundColor: Colors.grey.shade900.withOpacity(0.05),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 1,
                  color: Colors.grey.shade600,
                ),
                SizedBox(height: 10),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'helvetica',
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
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
                      customBorder: const CircleBorder(),
                      onTap: () {
                        _upVote();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: upSelectionColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.thumb_up, color: Colors.green.shade600, size: 30),
                            SizedBox(width: 4),
                            Text('$upVotes', style: TextStyle(fontSize: 22)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        _downVote();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: downSelectionColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.thumb_down, color: Colors.red.shade600, size: 30),
                            SizedBox(width: 4),
                            Text('$downVotes', style: TextStyle(fontSize: 22)),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PropositionScreen(proposition: widget.proposition),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.more_horiz, size: 24),
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