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
  bool _isContentExpanded = true;
  bool _isPathExpanded = false;

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
        title: Text('Créer une proposition'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              SingleChildScrollView(
                child: ExpansionPanelList(
                  elevation: 0,
                  expandedHeaderPadding: EdgeInsets.all(0),
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      if(!_isContentExpanded && _isPathExpanded) {
                        _isPathExpanded = false;
                      }
                      _isContentExpanded = !_isContentExpanded;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      //backgroundColor: Color.fromRGBO(111, 97, 211, 1),
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(
                            'Proposition',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(232, 232, 232, 1),
                              //color: Color.fromRGBO(111, 97, 211, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      body: Container(
                        constraints: BoxConstraints(maxHeight: 400),
                        child: Scaffold(
                          body: Column(children: [
                            SizedBox(height: 36),
                            TextField(
                              controller: _titleController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Titre',
                                labelStyle: TextStyle(color: Colors.grey),
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
                              style: TextStyle(color: Colors.white, fontSize: 17),
                              maxLines: null,
                              minLines: 10,
                              maxLength: 300,
                              decoration: const InputDecoration(
                                labelText: 'Contenu',
                                alignLabelWithHint: true,
                                labelStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ],),
                        )
                      ),
                      isExpanded: _isContentExpanded,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                child: ExpansionPanelList(
                  elevation: 0,
                  expandedHeaderPadding: EdgeInsets.all(0),
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      if(_isContentExpanded && !_isPathExpanded) {
                        _isContentExpanded = false;
                      }
                      _isPathExpanded = !_isPathExpanded;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      //backgroundColor: Color.fromRGBO(111, 97, 211, 1),
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(
                            'Cible: $_selectedPathResult',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(232, 232, 232, 1),
                              //color: Color.fromRGBO(111, 97, 211, 1),
                              fontWeight: FontWeight.w500,
                            ),),
                        );
                      },
                      body: Container(
                        constraints: BoxConstraints(maxHeight: 500),
                        child: PathSelection(
                          isPathSelection: true,
                        ),
                      ),
                      isExpanded: _isPathExpanded,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _createProposition,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      backgroundColor: Color.fromRGBO(111, 97, 211, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.publish, color: Color.fromRGBO(232, 232, 232, 1),),
                    label: const Text(
                      'Publiez la proposition',
                      style: TextStyle(fontSize: 18, color: Color.fromRGBO(232, 232, 232, 1),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
