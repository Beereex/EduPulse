import 'package:edupulse/screens/account/edit_account.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/user_infos.dart';
import '../../services/app_data.dart';

class ShowAccount extends StatefulWidget {
  @override
  _ShowAccountState createState() => _ShowAccountState();
}

class _ShowAccountState extends State<ShowAccount> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final _dispFontSize = 25.0;

  @override
  Widget build(BuildContext context) {
    UserInfos? userInfos = AppData.instance.userInfos;
    String picUrl = userInfos!.picUrl;
    String firstName = userInfos!.firstName;
    String lastName = userInfos!.lastName;
    String userType = userInfos!.userType;
    String userRole = userInfos!.user_role;
    String region = userInfos!.region;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Compte'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.teal.shade700.withOpacity(0.7),
                  width: 5.0,
                ),
              ),
              child: CircleAvatar(
                backgroundImage: picUrl == 'none'
                    ? AssetImage('assets/default_profile_pic.jpg')
                    : NetworkImage(picUrl) as ImageProvider,
                radius: 120,
              ),
            ),
            SizedBox(height: 30),
            Text(
              '$firstName $lastName',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _dispFontSize+10,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$userType - $userRole',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Région: $region',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _dispFontSize,
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent.withOpacity(0.1),
                minimumSize: Size(120, 60),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditAccount()),
                );
              },
              child: Text(
                'Modifier',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
