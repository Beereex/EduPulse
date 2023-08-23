import 'package:cloud_firestore/cloud_firestore.dart';

class Proposition {
  final String? id;
  String? title;
  String? content;
  String? type = "Undefined", grade = "Undefined", speciality = "Undefined", subject = "Undefined",cours = "Undefined";
  String? authorId;
  String? authorName = "Undefined";
  int? upvoteCount = 0;
  int? downvoteCount = 0;
  int? userVoteStatus = 0;
  DateTime? creationDate;
  DateTime? lastEditDate;


  Proposition({
    this.id,
    this.title,
    this.content,
    this.upvoteCount,
    this.downvoteCount,
    this.userVoteStatus,
    this.authorId,
    this.authorName,
    this.type,
    this.speciality,
    this.grade,
    this.subject,
    this.cours,
  });

  Future<Proposition?> getPropositionById(String id) async{
    try {
      DocumentSnapshot propositionSnapshot =
      await FirebaseFirestore.instance.collection('propositions').doc(id).get();
      String userName = "Undefined";

      if (propositionSnapshot.exists) {
        Map<String, dynamic> data = propositionSnapshot.data() as Map<String, dynamic>;
        
        DocumentSnapshot userSnapShot =
            await FirebaseFirestore.instance.collection(("users")).doc(data["author"]).get();
        if(userSnapShot.exists) {
          Map<String, dynamic> udata =
              userSnapShot.data() as Map<String, dynamic>;
          userName = udata["first_name"] + " " + udata["last_name"];
        }

        return Proposition(
          id: propositionSnapshot.id,
          title: data['title'],
          content: data['content'],
          upvoteCount: data['upVotes'],
          downvoteCount: data['downVotes'],
          userVoteStatus: data['userVoteStatus'],//search the user's votes, if exists do something, if not do something else, or else...
          authorId: data['author'],
          authorName: userName,
          type: data['type'],
          speciality: data['speciality'],
          grade: data['grade'],
          subject: data['subject'],
          cours: data['cours'],
        );
      } else {
        return null;
      }
    } catch (error) {
      print("Error fetching proposition: $error");
      return null;
    }
  }

  String getPath(){
    return "$type/$grade/$speciality/$subject/$cours";
  }
}
