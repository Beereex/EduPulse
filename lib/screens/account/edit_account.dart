import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/app_data.dart';

class EditAccountPage extends StatefulWidget {
  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  String _firstName = '';
  String _lastName = '';
  File? _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }
  }

  void _saveChanges() async {
    if (_pickedImage != null) {
      // Upload the image to Firebase Storage and get the image URL
      final imageUrl = await uploadImageToFirebaseStorage(_pickedImage!);

      // Update the user's document in Firestore with new data
      await FirebaseFirestore.instance.collection('users').doc(AppData.instance.currentUser!.uid).update({
        'firstName': _firstName,
        'lastName': _lastName,
        'picUrl': imageUrl,
      });

      // Navigate back to the Account page
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le compte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _pickedImage != null
                  ? FileImage(_pickedImage!)
                  : AppData.instance.currentUser!.p == 'none'
                  ? AssetImage('assets/default_profile_pic.jpg')
                  : NetworkImage(AppData.instance.currentUser!.picUrl) as ImageProvider,
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Choisir une photo'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Prénom'),
              onChanged: (value) {
                setState(() {
                  _firstName = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Nom'),
              onChanged: (value) {
                setState(() {
                  _lastName = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Enregistrer les modifications'),
            ),
          ],
        ),
      ),
    );
  }
}

// A placeholder function to simulate image uploading
Future<String> uploadImageToFirebaseStorage(File imageFile) async {
  await Future.delayed(Duration(seconds: 2)); // Simulate image uploading
  return 'https://example.com/uploaded_image.jpg'; // Return a placeholder image URL
}
