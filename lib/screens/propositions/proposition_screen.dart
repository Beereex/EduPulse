import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/proposition.dart';
import '../../services/app_data.dart';

class PropositionScreen extends StatefulWidget {
  final Proposition proposition;

  PropositionScreen({required this.proposition});

  @override
  State<StatefulWidget> createState() => _PropositionScreenState();



}

class _PropositionScreenState extends State<PropositionScreen>{
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
    resetSelectionColors();
    if(userVote == 1){
      selectUpColor();
    }
    else if(userVote == -1){
      selectDownColor();
    }
  }

  void resetSelectionColors(){
    setState(() {
      upSelectionColor = Colors.transparent;
      downSelectionColor = Colors.transparent;
    });
  }

  void selectUpColor(){
    setState(() {
      upSelectionColor = Colors.green.shade600.withOpacity(0.2);
    });
  }

  void selectDownColor(){
    setState(() {
      downSelectionColor = Colors.red.shade600.withOpacity(0.2);
    });
  }

  Future<void> _addVote(int voteType) async{
    try{
      await FirebaseFirestore.instance.collection("users").doc(AppData.instance.userInfos!.uid)
          .collection("votes").doc(widget.proposition.id).set({
        "vote": voteType,
        "voteDate": Timestamp.now(),
      });
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
    }
    catch(e){
      print("Error updating the vote: $e");
    }
  }

  Future<void> _removeVote() async{
    try{
      await FirebaseFirestore.instance.collection("users").doc(AppData.instance.userInfos!.uid)
          .collection("votes").doc(widget.proposition.id).delete();
    }
    catch(e){
      print("Error remoing the vote: $e");
    }
  }

  Future<void> _updatePropVotesCounter() async{
    try{
      await FirebaseFirestore.instance.collection("propositions").doc(widget.proposition.id).update({
        "upVotes" : upVotes,
        "downVotes" : downVotes,
      });
    }
    catch(e){
      print("Error updating vote: $e");
    }
  }

  void _upVote(){
    resetSelectionColors();
    if(userVote == 1){
      _removeVote();
      setState(() {
        upVotes--;
        userVote = 0;
      });
    }
    else if(userVote == -1){
      _updateVote(1);
      setState(() {
        upVotes++;
        downVotes--;
        userVote = 1;
        selectUpColor();
      });
    }
    else{
      _addVote(1);
      setState(() {
        upVotes++;
        userVote = 1;
        selectUpColor();
      });
    }
    setState(() {
      _updatePropVotesCounter();
    });
  }

  void _downVote(){
    resetSelectionColors();
    if(userVote == -1){
      _removeVote();
      setState(() {
        downVotes--;
        userVote = 0;
      });
    }
    else if(userVote == 1){
      _updateVote(-1);
      setState(() {
        upVotes--;
        downVotes++;
        userVote = -1;
        selectDownColor();
      });
    }
    else{
      _addVote(-1);
      setState(() {
        downVotes++;
        userVote = -1;
        selectDownColor();
      });
    }
    setState(() {
      _updatePropVotesCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proposition"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder<String>(
                          future: AppData.instance.getPicUrlFromId(widget.proposition.authorId!),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return CircularProgressIndicator();
                            }
                            else if(snapshot.hasError || snapshot.data == "none"){
                              return CircleAvatar(
                                backgroundImage: AssetImage('assets/default_profile_pic.jpg'),
                                radius: 50,
                              );
                            }
                            else{
                              print(snapshot.data);
                              return CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data),
                                radius: 50,
                              );
                            }
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          widget.proposition.title ?? '',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 26),
                  Text(
                    widget.proposition.content ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Auteur: ${widget.proposition.authorName ?? 'Unknown'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Cible: ${widget.proposition.path ?? ''}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Date de création: ${DateFormat("dd/MM/yyyy").format(widget.proposition.creationDate!.toDate()) ?? ''}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Date de dérnière édition: ${DateFormat("dd/MM/yyyy").format(widget.proposition.lastEditDate!.toDate()) ?? ''}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          _upVote();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: upSelectionColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.thumb_up, color: Colors.green.shade600, size: 20),
                              SizedBox(width: 4),
                              Text('$upVotes', style: TextStyle(fontSize: 17)),
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: downSelectionColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.thumb_down, color: Colors.red.shade600, size: 20),
                              SizedBox(width: 4),
                              Text('$downVotes', style: TextStyle(fontSize: 17)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
