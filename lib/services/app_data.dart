import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_infos.dart';


class AppData {
  static final AppData _instance = AppData._privateConstructor();

  AppData._privateConstructor();

  static AppData get instance => _instance;

  User? currentUser;
  UserInfos? userInfos;

  Future<String?> getUserRegion() async{
    return await userInfos?.region;
  }

  Future<Map<String, String>> getEducationTypes() async{
    Map<String, String> educationTypes = {};
    try{
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("educationTypes").get();
      querySnapshot.docs.forEach((doc){
        final String educationType = (doc.data() as Map<String, dynamic>)?["education_type"] as String;
        educationTypes[doc.id] = educationType;
      });
    }
    catch(e){
      print("Unable to retrieve education type data!!!:\n$e");
    }
    return educationTypes;
  }
  
  Future<Map<String, String>> getSpecialities(String eduTypeId) async{
    Map<String, String> specialities = {};
    try{
      final QuerySnapshot querySnapshot = 
          await FirebaseFirestore.instance.collection("educationTypes").doc(eduTypeId).collection("specialities").get();
      querySnapshot.docs.forEach((doc) {
        final String speciality = (doc.data() as Map<String, String>)?["speciality"] as String;
        specialities[doc.id] = speciality;
      });
    }
    catch(e){
      print("Error loading specialities for $eduTypeId: $e");
    }
    return specialities;
  }

  Future<Map<String, dynamic>?> getAppSettings()async {
    try
    {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection("settings")
              .doc("tqu1LE7CZEmDBgaJzhiI")
              .get();
      if (snapshot.exists) {
        return snapshot.data()!;
      }
      else{
        print("settings not found!!");
      }
    }
    catch(e){
      print("Error occured while loading data: $e");
    }
  }

  Future<UserInfos?> getUserData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).get();

      if (snapshot.exists) {
        final userData = snapshot.data()!;
        return UserInfos(
            uid: currentUser!.uid,
            firstName: userData['first_name'],
            lastName: userData['last_name'],
            picUrl: userData['pic_url'],
            userType: userData['userType'],
            region: userData['region'],
        );
      } else {
        print("User with UID ${currentUser?.uid} not found.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> setCurrentUser(User user) async {
    currentUser = user;
  }

  void updateUserProfile(String uid, String newPicUrl, String newFirstName, String newLastName) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'pic_url': newPicUrl,
        'first_name': newFirstName,
        'last_name': newLastName,
      });
      print('User profile updated successfully');
      _updateUserInfos(
        firstName: newFirstName,
        lastName: newLastName,
        picUrl: newPicUrl,
      );
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  void _updateUserInfos({
    String? firstName,
    String? lastName,
    String? picUrl,
  }) {
    if (firstName != null) userInfos!.firstName = firstName;
    if (lastName != null) userInfos!.lastName = lastName;
    if (picUrl != null) userInfos!.picUrl = picUrl;
  }


  Future<int> getVoteStatus(String propositionId) async{
    try{
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(userInfos?.uid)
          .collection("votes").doc(propositionId).get();
      if(snapshot.exists){
        final vote = snapshot.data()! as Map<String, dynamic>;
        return vote["voteValue"] as int;
      }
      else{
        return 0;
      }
      return 1;
    }
    catch(e){
      print("Error checking the vote status of the proposition: $e");
      return 0;
    }
  }

  String? getFullName(){
    return userInfos!.firstName + " " + userInfos!.lastName;
  }

  Future<void> updateVote(String propositionId, int vote) async{
    try{
      await FirebaseFirestore.instance.collection("users").doc(userInfos?.uid)
          .collection("votes").doc(propositionId).update({
            "voteValue" : vote,
            "voteDate" : Timestamp.now(),
      });
    }
    catch(e){
      print("Error updating the vote: $e");
    }
  }

  Future<void> addVote(String propositionId, int vote) async{
    try{
      await FirebaseFirestore.instance.collection("users").doc(userInfos?.uid)
          .collection("votes").doc(userInfos?.uid).set({
            "voteValue": vote,
            "voteDate" : Timestamp.now(),
      });
    }
    catch(e){
      print("Error adding the vote: $e");
    }
  }

}
