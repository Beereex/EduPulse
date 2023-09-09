import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/screens/propositions/path_selection.dart';
import 'package:edupulse/services/app_data.dart';
import 'package:flutter/material.dart';
import '../../models/proposition.dart';

class CreateProposition extends StatefulWidget {
  @override
  _CreatePropositionState createState() => _CreatePropositionState();
}

class _CreatePropositionState extends State<CreateProposition> {
  String _selectedPathResult = "";
  AppData data = AppData.instance;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _createProposition() async{
    try{
      CollectionReference propositions = FirebaseFirestore.instance.collection("propositions");
      Map<String, dynamic> proposition = {
        "title": _titleController.text,
        "content": _contentController.text,
        "path": _selectedPathResult,
        "creationDate": Timestamp.now(),
        "lastEditDate": Timestamp.now(),
        "author": data.userInfos!.uid,
        "status": 1,
        "upvotes": 0,
        "downvotes": 0,
        "region": data.userInfos!.region,
      };
      DocumentReference newPropRef = await propositions.add(proposition);
      print("new proposition created with id: ${newPropRef.id}");
      Navigator.pop(context);
    }
    catch(e){
      print("Error while creating a new proposition: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Proposition'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a New Proposition',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  final selectedPath = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PathSelection(isPathSelection: true,),
                        ),
                      ) ??
                      "Undefined";
                  setState(() {
                    _selectedPathResult = selectedPath;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(53, 21, 93, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(Icons.location_on, color: Colors.white),
                label: Text(
                  'Select Path',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              Text("$_selectedPathResult"),
              SizedBox(height: 16),
              TextField(
                controller: _titleController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Titre de la proposition',
                  labelStyle: TextStyle(color: Colors.white70),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _contentController,
                style: TextStyle(color: Colors.white, fontSize: 20),
                maxLines: null,
                minLines: 10,
                maxLength: 300,
                decoration: InputDecoration(
                  labelText: 'Contenu de la proposition',
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: Colors.white70),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _createProposition,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(53, 21, 93, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Créer la proposition',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
