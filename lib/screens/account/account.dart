import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _dispFontSize = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Compte'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _firestore.collection('users').doc(_auth.currentUser!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final data = snapshot.data!.data()!;
            final firstName = data['first_name'] ?? 'N/A';
            final lastName = data['last_name'] ?? 'N/A';
            final picUrl = data['pic_url'] ?? 'none';
            final userTypeRef = data['userType'] as DocumentReference?;

            return FutureBuilder<DocumentSnapshot>(
              future: userTypeRef?.get(),
              builder: (context, userTypeSnapshot) {
                if (userTypeSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (userTypeSnapshot.hasData) {
                  final userTypeData = userTypeSnapshot.data!.data() as Map<String, dynamic>?;

                  if (userTypeData != null) {
                    final userType = userTypeData['userType'] ?? 'N/A';

                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30,),
                          CircleAvatar(
                            radius: 120,
                            backgroundImage: picUrl == 'none'
                                ? AssetImage('assets/default_profile_pic.jpg')
                                : NetworkImage(picUrl) as ImageProvider,
                          ),
                          SizedBox(height: 70),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Prénom: $firstName',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: _dispFontSize,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Nom: $lastName',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: _dispFontSize,
                            ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Type de Compte: $userType',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: _dispFontSize,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditAccount()),
                              );
                            },
                            child: Text(
                              'Modifier',
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }

                return Center(
                  child: Text('Erreur lors de la récupération des informations du compte.'),
                );
              },
            );
          } else {
            return Center(
              child: Text('Erreur lors de la récupération des informations du compte.'),
            );
          }
        },
      ),
    );
  }
}
