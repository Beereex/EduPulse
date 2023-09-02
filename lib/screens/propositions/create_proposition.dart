import 'package:edupulse/screens/propositions/select_path.dart';
import 'package:edupulse/services/app_data.dart';
import 'package:flutter/material.dart';
import '../../models/proposition.dart';

class CreateProposition extends StatefulWidget {
  @override
  _CreatePropositionState createState() => _CreatePropositionState();
}

class _CreatePropositionState extends State<CreateProposition> {
  String? _selectedType;
  String? _selectedGrade;
  String? _selectedSubject;
  String? _selectedCourse;
  String _selectedPathResult = "";
  
  AppData data = AppData.instance;
  Map<String, dynamic> educationTypes = {};
  Map<String, String> specialities = {};

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  void _createProposition() {
    Proposition newProposition = Proposition(
      title: _titleController.text,
      content: _contentController.text,
      type: _selectedType,
      grade: _selectedGrade,
      subject: _selectedSubject,
      cours: _selectedCourse,
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
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
                onPressed: () async{
                  final selectedPath = await
                    Navigator.push<String>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PathSelection(),
                      ),
                    ) ?? "Undefined";
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
                style: TextStyle(color: Colors.white,fontSize: 20),
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
