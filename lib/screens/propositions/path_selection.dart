import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/screens/settings/add_path_element.dart';
import 'package:edupulse/screens/settings/admin_panel.dart';
import 'package:edupulse/screens/success_dialog.dart';
import 'package:flutter/material.dart';

class PathSelection extends StatefulWidget {
  bool isPathSelection = true;
  PathSelection({required this.isPathSelection});
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

  dynamic specialityFunc;
  dynamic gradeFunc;
  dynamic subjectFunc;
  dynamic coursFunc;

  String? newSpeciality;
  String? newGrade;
  String? newSubject;
  String? newCours;

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

  String _getIdFromValue(Map<String, String> map, String type){
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
    if(!widget.isPathSelection && path != "Undefined"){
      
    }     
    return path;
  }
  
  Future _saveSpecialityToDb()async{
    try{
      String educationTypeId = getIdFromValue(educationTypesMap, selectedEducationType!);
      await FirebaseFirestore.instance.collection("educationTypes").doc(educationTypeId)
          .collection("specialities").add({
        "speciality" : newSpeciality,
      });
    }
    catch(e){
      print("Error inserting path elements: $e");
    }
  }

  Future _saveGradeToDb()async{
    try{
      String educationTypeId = getIdFromValue(educationTypesMap, selectedEducationType!);
      String specialityId = getIdFromValue(specialitiesMap, selectedSpeciality!);

      final ref = await FirebaseFirestore.instance.collection("educationTypes").doc(educationTypeId)
          .collection("specialities").doc(specialityId)
          .collection("grade").add({
        "grade" : newGrade,
      });
      print(ref.id);
    }
    catch(e){
      print("Error inserting path elements: $e");
    }
  }

  Future _saveSubjectToDb()async{
    try{
      String educationTypeId = getIdFromValue(educationTypesMap, selectedEducationType!);
      String specialityId = getIdFromValue(specialitiesMap, selectedSpeciality!);
      String gradeId = getIdFromValue(gradesMap, selectedGrade!);

      await FirebaseFirestore.instance.collection("educationTypes").doc(educationTypeId)
          .collection("specialities").doc(specialityId)
          .collection("grades").doc(gradeId).collection("subjects").add({
        "subject" : newSubject,
      });
    }
    catch(e){
      print("Error inserting path elements: $e");
    }
  }

  Future _saveCoursToDb()async{
    try{
      String educationTypeId = getIdFromValue(educationTypesMap, selectedEducationType!);
      String specialityId = getIdFromValue(specialitiesMap, selectedSpeciality!);
      String gradeId = getIdFromValue(gradesMap, selectedGrade!);
      String coursId = getIdFromValue(coursesMap, selectedCours!);

      await FirebaseFirestore.instance.collection("educationTypes").doc(educationTypeId)
          .collection("specialities").doc(specialityId)
          .collection("grade").doc(gradeId).collection("subjects").doc(coursId)
          .collection("courses").add({
        "cours" : newCours,
      });
    }
    catch(e){
      print("Error inserting path elements: $e");
    }
  }

  void _reloadPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => AdminPanel(),
    ));
  }

  String getIdFromValue(Map<String, String> map, String value){
    String result = "";
    map.entries.forEach((e){
      if(e.value == value) {
        result = e.key;
      }
    });
    return result;
  }

  void activateSpecialityFunc(){
    setState(() {
      nullifyFunctions();
      specialityFunc = (){
        dialog("Créer une spécialité").then((value){
          newSpeciality = value;
          _saveSpecialityToDb();
          _reloadPage(context);
          showDialog(context: context, builder: (context){
            return SuccessDialog(message: "la spécialité : $newSpeciality à été enregistrer avec success!");
          });
        });
      };
    });
  }

  void activateGradeFunc(){
    setState(() {
      nullifyFunctions();
      gradeFunc = (){
          dialog("Créer un niveau scolaire").then((value) {
            newGrade = value;
            _saveGradeToDb();
            _reloadPage(context);
            showDialog(context: context, builder: (context){
              return SuccessDialog(message: "le niveau scolaire : $newGrade à été enregistrer avec success!");
            });
          });
      };
    });
  }

  void activateSubjectFunc(){
    setState(() {
      nullifyFunctions();
      subjectFunc = (){
        dialog("Créer une nouvelle matière").then((value){
        newSubject = value;
        _saveSubjectToDb();
        _reloadPage(context);
        showDialog(context: context, builder: (context){
          return SuccessDialog(message: "le niveau scolaire : $newGrade à été enregistrer avec success!");
          });
        });
      };
    });
  }

  void activateCourseFunc(){
    setState(() {
      nullifyFunctions();
      coursFunc = (){
        dialog("Créer un nouveau cours").then((value){
          newCours = value;
          _saveCoursToDb();
          _reloadPage(context);
          showDialog(context: context, builder: (context){
            return SuccessDialog(message: "le cours : $newCours à été enregistrer avec success!");
          });
        });
      };
    });
  }

  void nullifyFunctions(){
    specialityFunc = gradeFunc = subjectFunc = coursFunc = null;
  }

  Future<String> dialog(String label) async{
    return await showDialog(context: context, builder: (context){
      return AddPathElement(labelText: label);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isPathSelection
          ? AppBar(title: Text('Sélectionner le Chemin'),)
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.isPathSelection
                    ? "Sélectionner les Éléments du Chemin"
                    : "Créer les Éléments du Chemin",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Visibility(
                visible: !widget.isPathSelection,
                  child: const SizedBox(height: 40,),
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: "Type d'éducation",
                items: educationTypesMap.entries.map((e) => e.value).toList(),
                selectedItem: selectedEducationType,
                onChanged: (value){
                  selectedEducationType = value;
                  gradesMap = subjectsMap = coursesMap = {};
                  selectedSpeciality = selectedGrade = selectedSubject = selectedCours = null;
                  _fillSpecialities(_getIdFromValue(educationTypesMap, value ?? "")).then((result){
                    setState(() {
                      specialitiesMap = result;
                      if(selectedEducationType != ""){
                        activateSpecialityFunc();
                      }
                    });
                  });
                },
                isAdd: true,
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
                  _fillGrades(_getIdFromValue(educationTypesMap, selectedEducationType ?? ""),
                      _getIdFromValue(specialitiesMap, selectedSpeciality ?? "")).then((result){
                        setState(() {
                          gradesMap = result;
                          if(selectedSpeciality != ""){
                            activateGradeFunc();
                          }
                        });
                  });
                },
                isAdd: widget.isPathSelection,
                func: specialityFunc,
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
                  _fillSubjects(_getIdFromValue(educationTypesMap, selectedEducationType ?? ""),
                      _getIdFromValue(specialitiesMap, selectedSpeciality ?? ""),
                      _getIdFromValue(gradesMap, selectedGrade ?? "")).then((result){
                    setState(() {
                      subjectsMap = result;
                      if(selectedGrade != ""){
                        activateSubjectFunc();
                      }
                    });
                  });
                },
                isAdd: widget.isPathSelection,
                func: gradeFunc,
              ),
              SizedBox(height: 16),
              _buildDropdown(
                label: 'Matière',
                items: subjectsMap.entries.map((e) => e.value).toList(),
                selectedItem: selectedSubject,
                onChanged: (value) {
                  selectedSubject = value;
                  selectedCours = null;
                  _fillCourses(_getIdFromValue(educationTypesMap, selectedEducationType ?? ""),
                      _getIdFromValue(specialitiesMap, selectedSpeciality ?? ""),
                      _getIdFromValue(gradesMap, selectedGrade ?? ""),
                      _getIdFromValue(subjectsMap, selectedSubject ?? "")).then((result){
                    setState(() {
                      coursesMap = result;
                      if(selectedSubject != ""){
                        activateCourseFunc();
                      }
                    });
                  });
                },
                isAdd: widget.isPathSelection,
                func: subjectFunc,
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
                isAdd: widget.isPathSelection,
                func: coursFunc,
              ),
              const SizedBox(height: 32),
              Visibility(
                visible: widget.isPathSelection,
                child: ElevatedButton(
                  onPressed: () {
                    widget.isPathSelection
                        ? Navigator.pop(context, _pathBuilder())
                        : (){};
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(53, 21, 93, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Confirmer la Sélection",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
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
    required isAdd,
    func,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
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
          ),
        ),
        Visibility(
          visible: !isAdd,
          child: ElevatedButton(
            onPressed: func,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
