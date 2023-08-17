import 'package:cloud_firestore/cloud_firestore.dart';

class ExtendedUser {
  String uid;
  String firstName;
  String lastName;
  String picUrl;
  String userTypeRef;
  String userType;

  // Constructor
  ExtendedUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.picUrl,
    required this.userTypeRef,
    required this.userType,
  }){
    this.userType = getFieldFromDocument(this.userTypeRef, "userType").;
  }

  // Update user data from a map
  void updateFromMap(Map<String, dynamic> map) {
    firstName = map['first_name'];
    lastName = map['last_name'];
    picUrl = map['pic_url'];
    userTypeRef = map['userType'];
  }

  Future<String?> getFieldFromDocument(String documentReference, String fieldName) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.doc(documentReference).get();

      if (snapshot.exists) {
        return snapshot.get(fieldName);
      } else {
        return null; // Document doesn't exist
      }
    } catch (e) {
      print("Error getting document: $e");
      return null;
    }
  }
}
