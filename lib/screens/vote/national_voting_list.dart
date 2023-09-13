import 'package:flutter/material.dart';
import "../../services/app_data.dart";

class NationalVotingList extends StatefulWidget {
  const NationalVotingList({super.key});

  @override
  State<NationalVotingList> createState() => _NationalVotingListState();
}

class _NationalVotingListState extends State<NationalVotingList> {
  @override
  Widget build(BuildContext context) {
    if(AppData.instance.currentPhase == "Propositions" || AppData.instance.currentPhase == "Repos"){
      return Scaffold(
        appBar: AppBar(title: Text("Vote Nationale"),),
        body: Text("Phase de proposition est pas encore ouverte!!"),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text("Vote Nationale"),),
      body: Text("vote list"),
    );
  }
}

