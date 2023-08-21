import 'dart:io';
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
  String _selectedImage = "";
  File? _selectedImageFile;
  UserInfos userInfos = AppData.instance.userInfos!;

  @override
  void initState() {
    super.initState();
    // Initialize text fields with existing user data
    _firstNameController.text = userInfos.firstName;
    _lastNameController.text = userInfos.lastName;
    _selectedImage = userInfos.picUrl;
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
                  ? _selectedImage == "none"
                    ? AssetImage('assets/default_profile_pic.jpg') as ImageProvider
                    : NetworkImage(_selectedImage)
                  : FileImage(_selectedImageFile!) as ImageProvider,
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
              onPressed: () {
                // TODO: Save changes
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage.path;
        _selectedImageFile = File(pickedImage.path); // Convert PickedFile to File
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
