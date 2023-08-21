class UserInfos {
  final String uid;
  String firstName;
  String lastName;
  String picUrl;
  final String user_role;
  final String userType;
  final String region;

  UserInfos({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.picUrl,
    required this.user_role,
    required this.userType,
    required this.region,
  });

  void printInfos(){
    print("UID $uid:");
    print("First Name: $firstName");
    print("Last Name: $lastName");
    print("Picture URL: $picUrl");
    print("Account Type: $userType");
    print("Role: $user_role");
    print("Region: $region");
  }
}