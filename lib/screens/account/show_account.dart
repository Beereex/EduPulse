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
    String region = userInfos!.region;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Center(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                child: Text(
                  region,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromRGBO(232, 232, 232, 1),
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 100),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromRGBO(111, 97, 211, 1),
                  width: 2.0,
                ),
              ),
              child: CircleAvatar(
                backgroundImage: picUrl == 'none'
                    ? AssetImage('assets/default_profile_pic.jpg')
                    : NetworkImage(picUrl) as ImageProvider,
                radius: 110,
              ),
            ),
            SizedBox(height: 13,),
            Text(
              "[ $userType ]",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _dispFontSize+5,
              ),
            ),
            SizedBox(height: 13,),
            Text(
              '$firstName $lastName',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _dispFontSize+10,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(111, 97, 211, 1),
                //minimumSize: Size(120, 60),
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
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
