import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/screens/propositions/proposition_card.dart';
import 'package:flutter/material.dart';
import '../../models/proposition.dart';

class SearchPropositions extends StatelessWidget {
  List<String>? propositionsIds = [];
  List<Proposition>? propositionsList = [];
  List<PropositionCard>? propositionCards = [];
  int fetchLimit = 1, displayedNumber=0,currentPosition=0;

  Future<List<String>> getPropositionIds() async {
    List<String> propositionIds = [];
    QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("propositions").get();
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      propositionIds.add(documentSnapshot.id);
    }
    return propositionIds;
  }

  Future<void> fillPropositionsList() async{
    for(String id in propositionsIds!){
      propositionsList?.add((await Proposition.getPropositionById(id))!);
    }
  }

  Future<List<PropositionCard>> getPropositionCards() async{
    propositionsIds = await getPropositionIds();
    await fillPropositionsList();
    for(Proposition proposition in propositionsList!){
      print(proposition.getPath());
      PropositionCard card = PropositionCard(proposition: proposition,);
      print(card.title);
      propositionCards?.add(card!);
    }
    return propositionCards!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Propositions'),
      ),
      body: FutureBuilder<List<PropositionCard>> (
        future: getPropositionCards(),
        builder: (BuildContext context, AsyncSnapshot<List<PropositionCard>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              children: [
                _buildSearchFilterSection(),
                Expanded(
                  child: ListView(
                    children: snapshot.data!,
                  ),
                ),
              ],
            );
          };
        }),
      );
  }
  /*

   */

  Widget _buildSearchFilterSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Filter and Search Options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Option 1'),
          Text('Option 2'),
          Text('Option 3'),
          // Add more options as needed
        ],
      ),
    );
  }
}
