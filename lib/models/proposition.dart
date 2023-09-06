import 'package:cloud_firestore/cloud_firestore.dart';

class Proposition {
  final String? id;
  String? title;
  String? content;
  String? path;
  String? authorId;
  String? authorName;
  int? upvoteCount;
  int? downvoteCount;
  int? userVoteStatus;
  Timestamp? creationDate;
  Timestamp? lastEditDate;
  String? region;
  int? status;


  Proposition({
    this.id,
    this.title,
    this.content,
    this.upvoteCount,
    this.downvoteCount,
    this.userVoteStatus,
    this.authorId,
    this.authorName,
    this.path,
    this.creationDate,
    this.lastEditDate,
    this.region,
    this.status,
  });

  static Future<Proposition?> getPropositionById(String id) async{
    try {
      DocumentSnapshot propositionSnapshot =
      await FirebaseFirestore.instance.collection('propositions').doc(id).get();
      String userName = "Undefined";
      int? userVoteStatus;

      if (propositionSnapshot.exists) {
        Map<String, dynamic> data = propositionSnapshot.data() as Map<String, dynamic>;
        DocumentSnapshot userSnapShot =
            await FirebaseFirestore.instance.collection("users").doc(data["author"]).get();
        if(userSnapShot.exists) {
          Map<String, dynamic> udata = userSnapShot.data() as Map<String, dynamic>;
          userName = udata["first_name"] + " " + udata["last_name"];
        }
        await FirebaseFirestore.instance.collection("users").doc(data["author"])
            .collection("votes").doc(propositionSnapshot.id).get().then((result){
          if(result.exists){
            userVoteStatus = (result.data() as Map<String, dynamic>)["vote"] as int;
          }
        });

        return Proposition(
          id: propositionSnapshot.id,
          title: data['title'],
          content: data['content'],
          upvoteCount: data['upVotes'],
          downvoteCount: data['downVotes'],
          userVoteStatus: userVoteStatus,
          authorId: data['author'],
          authorName: userName,
          path: data['path'],
          creationDate: data['creationDate'],
          lastEditDate: data['lastEditDate'],
          region: data["region"],
          status: data["status"],
        );
      }
    } catch (error) {
      print("Error fetching proposition: $error");
      return null;
    }
  }
}
