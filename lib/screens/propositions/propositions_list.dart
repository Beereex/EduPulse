import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/screens/propositions/proposition_card.dart';
import 'package:flutter/material.dart';
import '../../models/proposition.dart';
import '../search_filter_zone.dart';

class SearchPropositions extends StatelessWidget {
  List<String>? propositionsIds = [];
  List<Proposition>? propositionsList = [];
  List<PropositionCard>? propositionCards = [];
  int fetchLimit = 1, displayedNumber=0,currentPosition=0;
  SearchFilterZone searchFilter = SearchFilterZone(onSearch: (String ) {  }, onFilter: () {  },);

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
    int i = 0;
    for(String id in propositionsIds!){
      propositionsList?.add((await Proposition.getPropositionById(id))!);
      print("userVote from prop list: ${propositionsList![i].userVoteStatus ?? 'null'}");
      i++;
    }
  }

  Future<List<PropositionCard>> getPropositionCards() async{
    propositionsIds = await getPropositionIds();
    await fillPropositionsList();
    for(Proposition proposition in propositionsList!){
      PropositionCard card = PropositionCard(proposition: proposition,);
      propositionCards?.add(card);
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
                searchFilter,
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
}
