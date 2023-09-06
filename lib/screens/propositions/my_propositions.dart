import 'package:edupulse/models/proposition.dart';
import 'package:edupulse/models/proposition_methods.dart';
import 'package:edupulse/screens/propositions/proposition_card.dart';
import 'package:flutter/material.dart';

class MyPropositions extends StatefulWidget {
  Map<String, PropositionCard> myPropCards = {};
  int fetchCount = 5;
  String filter = "creationDate";
  bool desc = false;

  MyPropositions({super.key});


  @override
  State<MyPropositions> createState() => _MyPropositionsState();
}

class _MyPropositionsState extends State<MyPropositions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Propositions"),
      ),
      body: Center(
        child: FutureBuilder<Map<String,Proposition>>(
          future: PropositionMethods.getPropositionsList(widget.filter, widget.fetchCount, widget.desc),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if(snapshot.hasError){
              return const Text("Error loading propositions");
            }
            else{
              widget.myPropCards = PropositionMethods.buildPropCardsFromPropMap(snapshot.data);
              return ListView(
                children: widget.myPropCards.values.toList(),
              );
            }
          },
        )
      ),
    );
  }
}

