


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/models/vote.dart';
import 'package:edupulse/screens/vote/vote_card.dart';
import 'package:edupulse/services/app_data.dart';

class VoteMethods{
  static Future<Map<String, Vote>> getVotesList(String filter, int fetchCount, bool desc) async {
    Map<String, Vote> votesList = {};
    try {
      final snapShot = await FirebaseFirestore.instance
          .collection("users")
          .doc(AppData.instance.userInfos!.uid)
          .collection("votes")
          .get();

      final futures = snapShot.docs.map((voteDoc) async {
        final voteData = voteDoc.data();
        final propTitleSnapShot =
        await FirebaseFirestore.instance.collection("propositions").doc(voteDoc.id).get();
        if (propTitleSnapShot.exists) {
          final propTitleData = propTitleSnapShot.data()!;
          Vote vote = Vote(
            vote: voteData["vote"],
            date: voteData["voteDate"],
            propositionId: voteDoc.id,
            propositionTitle: propTitleData["title"],
          );
          votesList[voteDoc.id] = vote;
        } else {
          print("Error loading proposition title");
        }
      });

      await Future.wait(futures);
    } catch (e) {
      print("Error loading votes list: $e");
    }
    return votesList;
  }


  static Map<String, VoteCard> buildPropCardsFromPropMap(Map<String, Vote> votesMap){
    Map<String, VoteCard> voteCardsList = {};
    votesMap.forEach((key, value) {
      voteCardsList[key] = VoteCard(vote: value);
    });
    return voteCardsList;
  }
}