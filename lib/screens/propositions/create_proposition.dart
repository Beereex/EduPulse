import 'package:flutter/material.dart';
import '../../models/proposition.dart'; // Import your Proposition class

class CreateProposition extends StatefulWidget {
  @override
  _CreatePropositionState createState() => _CreatePropositionState();
}

class _CreatePropositionState extends State<CreateProposition> {
  String? _selectedType;
  String? _selectedGrade;
  String? _selectedSpeciality;
  String? _selectedSubject;
  String? _selectedCourse;

  List<String> _types = ['Type 1', 'Type 2', 'Type 3']; // Example types
  List<String> _grades = ['Grade 1', 'Grade 2', 'Grade 3']; // Example grades
  List<String> _specialities = ['Speciality 1', 'Speciality 2', 'Speciality 3']; // Example specialities
  List<String> _subjects = ['Subject 1', 'Subject 2', 'Subject 3']; // Example subjects
  List<String> _courses = ['Course 1', 'Course 2', 'Course 3']; // Example courses

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  void _createProposition() {
    // Create a new Proposition object with the entered data
    Proposition newProposition = Proposition(
      title: _titleController.text,
      content: _contentController.text,
      type: _selectedType,
      grade: _selectedGrade,
      speciality: _selectedSpeciality,
      subject: _selectedSubject,
      cours: _selectedCourse,
      // Add other fields as needed
    );

    // Save the new proposition to your Firestore or backend here

    Navigator.pop(context); // Navigate back to the previous page
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
                  color: Colors.white, // Title color
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: _types.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Type',
                  labelStyle: TextStyle(color: Colors.white70), // Label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedGrade,
                items: _grades.map((String grade) {
                  return DropdownMenuItem<String>(
                    value: grade,
                    child: Text(
                      grade,
                      style: TextStyle(color: Colors.black), // Text color
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGrade = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Grade',
                  labelStyle: TextStyle(color: Colors.white70), // Label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _titleController,
                style: TextStyle(color: Colors.white), // Text color
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white70), // Label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _contentController,
                style: TextStyle(color: Colors.white), // Text color
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(color: Colors.white70), // Label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _createProposition,
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(53, 21, 93, 1), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Button shape
                  ),
                ),
                icon: Icon(Icons.add, color: Colors.white), // Icon color
                label: Text(
                  'Create Proposition',
                  style: TextStyle(fontSize: 18, color: Colors.white), // Text style
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
