class ExtendedUser {
  String uid;
  String firstName;
  String lastName;
  String picUrl;
  String userType;

  // Constructor
  ExtendedUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.picUrl,
    required this.userType,
  });

  // Update user data from a map
  void updateFromMap(Map<String, dynamic> map) {
    firstName = map['first_name'];
    lastName = map['last_name'];
    picUrl = map['pic_url'];
    userType = map['userType'];
  }
}
