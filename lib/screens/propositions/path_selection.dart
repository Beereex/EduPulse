import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PathSelection extends StatefulWidget {
  bool showTitle = true;
  PathSelection({required this.showTitle});
  @override
  _PathSelectionState createState() => _PathSelectionState();
}

class _PathSelectionState extends State<PathSelection> {
  String? selectedEducationType;
  String? selectedSpeciality;
  String? selectedGrade;
  String? selectedSubject;
  String? selectedCours;

  Map<String, String> educationTypesMap = {};
  Map<String, String> specialitiesMap = {};
  Map<String, String> gradesMap = {};
  Map<String, String> subjectsMap = {};
  Map<String, String> coursesMap = {};

  @override
  void initState(){
    super.initState();
    _fillEducationTypesMap().then((result){
      setState(() {
        educationTypesMap = result;
      });
    });
  }


  Future<Map<String, String>> _fillEducationTypesMap() async{
    Map<String, String> eduTypes = {};
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("educationTypes").get();
      snapshot.docs.forEach((type) {
        eduTypes[type.id]= type["education_type"] as String;
      });
    }
    catch(e){
      print("Error loading types: $e");
    }
    return eduTypes;
  }

  Future<Map<String, String>> _fillSpecialities(String typeId) async{
    Map<String, String> specs = {};
    try{
      final snapshot = await FirebaseFirestore.instance.collection("educationTypes")
          .doc(typeId).collection("specialities").get();
      snapshot.docs.forEach((speciality) {
        specs[speciality.id] = speciality["speciality"] as String;
      });
    }
    catch(e){
      print("Error loading specialities: $e");
    }
    return specs;
  }

  Future<Map<String, String>> _fillGrades(String typeId, String specialityId) async{
    Map<String, String> grades = {};
    try{
      final snapshot = await FirebaseFirestore.instance.collection("educationTypes")
          .doc(typeId).collection("specialities").doc(specialityId)
          .collection("grade").get();
      snapshot.docs.forEach((grade) {
        grades[grade.id] = grade["grade"] as String;
      });
    }
    catch(e){
      print("Error loading grades: $e");
    }
    return grades;
  }

  Future<Map<String, String>> _fillSubjects(String typeId, String specialityId, String gradeId) async{
    Map<String, String> subjects = {};
    try{
      final snapshot = await FirebaseFirestore.instance.collection("educationTypes")
          .doc(typeId).collection("specialities").doc(specialityId)
          .collection("grade").doc(gradeId)
          .collection("subjects").get();
      snapshot.docs.forEach((subject) {
        subjects[subject.id] = subject["subject"] as String;
      });
    }
    catch(e){
      print("Error loading subjects: $e");
    }
    return subjects;
  }

  Future<Map<String, String>> _fillCourses(String typeId, String specialityId,
      String gradeId, String subjectId) async{
    Map<String, String> courses = {};
    try{
      final snapshot = await FirebaseFirestore.instance.collection("educationTypes")
          .doc(typeId).collection("specialities").doc(specialityId)
          .collection("grade").doc(gradeId)
          .collection("subjects").doc(subjectId)
          .collection("courses").get();
      snapshot.docs.forEach((cours) {
        courses[cours.id] = cours["cours"] as String;
      });
    }
    catch(e){
      print("Error loading courses: $e");
    }
    return courses;
  }

  String _getIdfromValue(Map<String, String> map, String type){
    String id = "";
    map.entries.forEach((element) {
      if(element.value == type)
        id = element.key;
    });
    return id;
  }

  String _pathBuilder(){
    String path = ("$selectedEducationType/" ?? "Undefined");
    if(selectedSpeciality != null)
      path += "$selectedSpeciality/";
    if(selectedGrade != null)
      path += "$selectedGrade/";
    if(selectedSubject != null)
      path += "$selectedSubject/";
    if(selectedCours != null)
      path += "$selectedCours";
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showTitle
          ? AppBar(title: Text('Sélectionner le Chemin'),)
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sélectionner les Éléments du Chemin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: 'Type d\'éducation',
                items: educationTypesMap.entries.map((e) => e.value).toList(),
                selectedItem: selectedEducationType,
                onChanged: (value){
                  selectedEducationType = value;
                  gradesMap = subjectsMap = coursesMap = {};
                  selectedSpeciality = selectedGrade = selectedSubject = selectedCours = null;
                  _fillSpecialities(_getIdfromValue(educationTypesMap, value ?? "")).then((result){
                    setState(() {
                      specialitiesMap = result;
                    });
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: 'Spécialité',
                items: specialitiesMap.entries.map((e) => e.value).toList(),
                selectedItem: selectedSpeciality,
                onChanged: (value) {
                  selectedSpeciality = value;
                  subjectsMap = coursesMap = {};
                  selectedGrade = selectedSubject = selectedCours = null;
                  _fillGrades(_getIdfromValue(educationTypesMap, selectedEducationType ?? ""),
                      _getIdfromValue(specialitiesMap, selectedSpeciality ?? "")).then((result){
                        setState(() {
                          gradesMap = result;
                        });
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: 'Niveau scolaire',
                items: gradesMap.entries.map((e) => e.value).toList(),
                selectedItem: selectedGrade,
                onChanged: (value) {
                  selectedGrade = value;
                  coursesMap = {};
                  selectedSubject = selectedCours = null;
                  _fillSubjects(_getIdfromValue(educationTypesMap, selectedEducationType ?? ""),
                      _getIdfromValue(specialitiesMap, selectedSpeciality ?? ""),
                      _getIdfromValue(gradesMap, selectedGrade ?? "")).then((result){
                    setState(() {
                      subjectsMap = result;
                    });
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: 'Matière',
                items: subjectsMap.entries.map((e) => e.value).toList(),
                selectedItem: selectedSubject,
                onChanged: (value) {
                  selectedSubject = value;
                  selectedCours = null;
                  _fillCourses(_getIdfromValue(educationTypesMap, selectedEducationType ?? ""),
                      _getIdfromValue(specialitiesMap, selectedSpeciality ?? ""),
                      _getIdfromValue(gradesMap, selectedGrade ?? ""),
                      _getIdfromValue(subjectsMap, selectedSubject ?? "")).then((result){
                    setState(() {
                      coursesMap = result;
                    });
                  });
                },
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: 'Cours',
                items: coursesMap.entries.map((e) => e.value).toList(),
                selectedItem: selectedCours,
                onChanged: (value) {
                  setState(() {
                    selectedCours = value;
                  });
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _pathBuilder());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(53, 21, 93, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Confirmer la Sélection',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required String? selectedItem,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton<String>(
          value: selectedItem,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          isExpanded: true,
        ),
      ],
    );
  }
}
