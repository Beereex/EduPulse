import 'package:edupulse/models/vote.dart';
import 'package:edupulse/screens/search_filter_zone.dart';
import 'package:edupulse/screens/vote/vote_card.dart';
import 'package:edupulse/screens/vote/vote_methods.dart';
import 'package:flutter/material.dart';

class MyVotes extends StatefulWidget {
  int fetchCount = 5;
  String filter = "voteDate";
  bool desc = false;
  Map<String, VoteCard> myVoteCards = {};

  MyVotes({super.key});

  @override
  State<MyVotes> createState() => _MyVotesState();
}

class _MyVotesState extends State<MyVotes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Votes"),
      ),
      body: Center(
          child: Column(
            children: [
              SearchFilterZone(onSearch: (search){}, onFilter: (){}),
              FutureBuilder<Map<String,Vote>>(
                future: VoteMethods.getVotesList(widget.filter, widget.fetchCount, widget.desc),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if(snapshot.hasError){
                    return const Text("Error loading propositions");
                  }
                  else{
                    widget.myVoteCards = VoteMethods.buildPropCardsFromPropMap(snapshot.data);
                    return Expanded(
                      child: ListView(
                        children: widget.myVoteCards.values.toList(),
                      ),
                    );
                  }
                },
              ),
            ],
          )
      ),
    );
  }
}

