
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/models/proposition.dart';
import 'package:edupulse/screens/propositions/proposition_card.dart';
import 'package:edupulse/services/app_data.dart';

class PropositionMethods{
  static Future<Map<String, Proposition>> getPropositionsList(String filter, int count, bool desc)async{
    Map<String, Proposition> propList = {};
    try{
      final propsSnapShot = await FirebaseFirestore.instance.collection("propositions")
          .where("author", isEqualTo: AppData.instance.userInfos!.uid)
          .orderBy(filter, descending: desc)
          .limit(count)
          .get();
      if(propsSnapShot != null){
        propsSnapShot.docs.forEach((proposition) {
          final prop = proposition.data();
          Proposition newProp = Proposition(
            id: proposition.id,
            title: prop["title"],
            content: prop["content"],
            creationDate: prop["creationDate"],
            lastEditDate: prop["lastEditDate"],
            path: prop["path"],
            region: prop["region"],
            status: prop["status"],
            upvoteCount: prop["upVotes"],
            downvoteCount: prop["downVotes"],
            authorName: AppData.instance.getFullName(),
          );
          propList.addAll({proposition.id : newProp});
        });
      }
      else{
        print("Error at proposition_Methods, getPropositionsList: propsSnapShot is null");
      }
    }
    catch(e){
      print("Error at proposition_Methods, getPropositionsList: $e");
    }
    return propList;
  }

  static Map<String, PropositionCard> buildPropCardsFromPropMap(Map<String, Proposition> propositionsMap){
    Map<String, PropositionCard> propCardsList = {};
    propositionsMap.forEach((key, value) {
      propCardsList[key] = PropositionCard(proposition: value);
    });
    return propCardsList;
  }

  static Future<String> getPropositionTitleFromId(String propositionId) async{
    String title = "";
    try{
      final documentSnapshot = await FirebaseFirestore.instance.collection("propositions").doc(propositionId).get();
      if(documentSnapshot.exists){
        final docData = documentSnapshot.data()!;
        title = docData["title"];
      }
      else{
        print("proposition id incorrect!");
      }
    }
    catch(e){
      print("Error reading proposition title: $e");
    }
    return title;
  }
}