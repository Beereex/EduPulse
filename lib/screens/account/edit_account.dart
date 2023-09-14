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
    _firstNameController.text = userInfos.firstName;
    _lastNameController.text = userInfos.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier Mon Profil'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70,),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromRGBO(111, 97, 211, 1),
                  width: 2.0,
                ),
              ),
              child: CircleAvatar(
                backgroundImage: _selectedImageFile == null
                    ? userInfos.picUrl == "none"
                    ? AssetImage('assets/default_profile_pic.jpg') as ImageProvider
                    : NetworkImage(userInfos.picUrl)
                    : FileImage(_selectedImageFile!),
                radius: 110,
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _takePicture,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Prendre une Photo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(111, 97, 211, 1),
                  ),
                ),
                Spacer(),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.photo),
                  label: Text('Depuis la Galerie'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(111, 97, 211, 1),
                  ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(111, 97, 211, 1),
              ),
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
    if (_selectedImageFile != null) {
      final storageRef = FirebaseStorage.instance.ref().child('profile_images/$uid');
      await storageRef.putFile(_selectedImageFile!);
      newImageUrl = await storageRef.getDownloadURL();
      _selectedImageFile = null;
    } else {
      newImageUrl = "none";
    }
    AppData.instance.updateUserProfile(uid!, newImageUrl, newFirstName, newLastName);
    Navigator.of(context).pop();
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
