import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String? userType;
  String? region;
  String accessPath = '';
  String firstName = '';
  String lastName = '';
  String picUrl = '';

  // Function to generate a random password
  String generateRandomPassword() {
    // Generate a random 10-character password
    final String charset = 'abcdefghijklmnopqrstuvwxyz0123456789_';
    final random = Random.secure();
    return List.generate(10, (index) => charset[random.nextInt(charset.length)]).join();
  }

  // Function to handle user creation and data storage
  void createUser() async {
    if (_formKey.currentState!.validate()) {
      // Validate and save the form
      _formKey.currentState?.save();

      try {
        // Firebase Authentication: Create a user with email and password
        // Replace with your Firebase authentication code
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: generateRandomPassword(),
        );

        // Get the user's UID
        String? uid = FirebaseAuth.instance.currentUser?.uid;

        // Firestore: Save user data to Firestore
        // Replace with your Firestore code to save user data
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'f_name': firstName,
          'l_name': lastName,
          'region': region,
          'pic_url': picUrl.isNotEmpty ? picUrl : null,
          'userType': userType,
          'access_path': accessPath,
        });

        // Navigate to another page or perform any necessary actions
        // ...
      } catch (e) {
        // Handle errors (e.g., Firebase authentication errors)
        print('Error creating user: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Adresse e-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value!.contains('@')) {
                      return 'Veuillez entrer une adresse e-mail valide.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: 'Chemin d\'accès'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un chemin d\'accès.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    accessPath = value!;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle access path generation and navigation
                    // You can navigate to another page to generate the path string
                    // and return it to this page
                  },
                  child: Text('Générer le chemin d\'accès'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Prénom (facultatif)'),
                  onSaved: (value) {
                    firstName = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nom (facultatif)'),
                  onSaved: (value) {
                    lastName = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'URL de la photo (facultatif)'),
                  onSaved: (value) {
                    picUrl = value!;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Create the user and save data
                    createUser();
                  },
                  child: Text('Enregistrer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
