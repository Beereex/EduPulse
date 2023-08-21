import 'dart:io';
import 'package:edupulse/screens/home/home.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/user_infos.dart';
import '../../services/app_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _imagePicker = ImagePicker();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  File? _selectedImageFile;
  UserInfos userInfos = AppData.instance.userInfos!;

  @override
  void initState() {
    super.initState();
    // Initialize text fields with existing user data
    _firstNameController.text = userInfos.firstName;
    _lastNameController.text = userInfos.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier Mon Compte'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 120,
              backgroundImage: _selectedImageFile == null
                ? userInfos.picUrl == "none"
                  ? AssetImage('assets/default_profile_pic.jpg') as ImageProvider
                  : NetworkImage(userInfos.picUrl)
                : FileImage(_selectedImageFile!)
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: _takePicture,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Prendre une Photo'),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.photo),
                  label: Text('Choisir depuis la Galerie'),
                ),
              ],
            ),
            SizedBox(height: 30),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'Prénom',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Nom',
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }


  void _saveChanges() async {
    String? uid = AppData.instance.userInfos?.uid;
    String newFirstName = _firstNameController.text;
    String newLastName = _lastNameController.text;

    String newImageUrl;

    // Check if a new image was selected
    if (_selectedImageFile != null) {
      // Upload the image to Firebase Cloud Storage
      final storageRef = FirebaseStorage.instance.ref().child('profile_images/$uid');
      await storageRef.putFile(_selectedImageFile!);

      // Get the download URL of the uploaded image
      newImageUrl = await storageRef.getDownloadURL();
      _selectedImageFile = null;
    } else {
      newImageUrl = "none";
    }

    // Update user profile data in Firestore
    AppData.instance.updateUserProfile(uid!, newImageUrl, newFirstName, newLastName);

    Navigator.of(context).pop(); // Close the EditAccount page
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Home()));
  }



  void _pickImage() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImageFile = File(pickedImage.path);
      });
    }
  }

  void _takePicture() async {
    final takenImage = await _imagePicker.pickImage(source: ImageSource.camera);
    if (takenImage != null) {
      setState(() {
        _selectedImageFile = File(takenImage.path); // Convert PickedFile to File
      });
    }
  }
}
