import 'package:flutter/material.dart';
import '../../models/proposition.dart';

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

  List<String> _types = ['Type 1', 'Type 2', 'Type 3'];
  List<String> _grades = ['Grade 1', 'Grade 2', 'Grade 3'];
  List<String> _specialities = ['Speciality 1', 'Speciality 2', 'Speciality 3'];
  List<String> _subjects = ['Subject 1', 'Subject 2', 'Subject 3'];
  List<String> _courses = ['Course 1', 'Course 2', 'Course 3'];

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  void _createProposition() {
    Proposition newProposition = Proposition(
      title: _titleController.text,
      content: _contentController.text,
      type: _selectedType,
      grade: _selectedGrade,
      speciality: _selectedSpeciality,
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
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedGrade,
                      items: _grades.map((String grade) {
                        return DropdownMenuItem<String>(
                          value: grade,
                          child: Text(
                            grade,
                            style: TextStyle(color: Colors.white70),
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
                        labelStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCourse,
                      items: _courses.map((String course) {
                        return DropdownMenuItem<String>(
                          value: course,
                          child: Text(
                            course,
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCourse = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Course',
                        labelStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedSpeciality,
                      items: _specialities.map((String speciality) {
                        return DropdownMenuItem<String>(
                          value: speciality,
                          child: Text(
                            speciality,
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSpeciality = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Speciality',
                        labelStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedSubject,
                      items: _subjects.map((String subject) {
                        return DropdownMenuItem<String>(
                          value: subject,
                          child: Text(
                            subject,
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSubject = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        labelStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                controller: _titleController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Title',
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
                style: TextStyle(color: Colors.white),
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(color: Colors.white70),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 32),
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
                  'Create Proposition',
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
