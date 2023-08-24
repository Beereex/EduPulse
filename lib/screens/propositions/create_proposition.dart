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
                decoration: InputDecoration(labelText: 'Type'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedGrade,
                items: _grades.map((String grade) {
                  return DropdownMenuItem<String>(
                    value: grade,
                    child: Text(grade),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGrade = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Grade'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedSpeciality,
                items: _specialities.map((String speciality) {
                  return DropdownMenuItem<String>(
                    value: speciality,
                    child: Text(speciality),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSpeciality = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Speciality'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedSubject,
                items: _subjects.map((String subject) {
                  return DropdownMenuItem<String>(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSubject = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Subject'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCourse,
                items: _courses.map((String course) {
                  return DropdownMenuItem<String>(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCourse = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Course'),
              ),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _contentController,
                maxLines: null,
                decoration: InputDecoration(labelText: 'Content'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _createProposition,
                child: Text('Create Proposition'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
