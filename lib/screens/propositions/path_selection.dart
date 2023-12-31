import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupulse/screens/settings/add_path_element.dart';
import 'package:edupulse/screens/settings/admin_panel.dart';
import 'package:edupulse/screens/success_dialog.dart';
import 'package:flutter/material.dart';

class PathSelection extends StatefulWidget {
  bool isPathSelection = true;
  dynamic? updateFunction;
  PathSelection({
    required this.isPathSelection,
    required this.updateFunction,
  });
  @override
  _PathSelectionState createState() => _PathSelectionState();
}

class _PathSelectionState extends State<PathSelection> {
  static const int _educationTypeIndex = 0, _specialityIndex = 1,
      _gradeIndex = 2, _subjectIndex = 3, _coursIndex = 4;
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
      if(element.value == type) {
        id = element.key;
      }
    });
    return id;
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
          .collection("grade").doc(gradeId).collection("subjects").add({
        "subject" : newSubject,
      }).then((value) => print(value));
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
      String subjectId = getIdFromValue(subjectsMap, selectedSubject!);

      await FirebaseFirestore.instance.collection("educationTypes").doc(educationTypeId)
          .collection("specialities").doc(specialityId)
          .collection("grade").doc(gradeId).collection("subjects").doc(subjectId)
          .collection("courses").add({
        "cours" : newCours,
      }).then((value) => print(value));
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
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Visibility(
                visible: !widget.isPathSelection,
                  child: const SizedBox(height: 40,),
              ),
              const SizedBox(height: 16),
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
                        if(widget.isPathSelection){
                          widget.updateFunction(_educationTypeIndex,selectedEducationType);
                        }
                      }
                    });
                  });
                },
                isAdd: true,
              ),
              const SizedBox(height: 16),
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
                            if(widget.isPathSelection){
                              widget.updateFunction(_specialityIndex,selectedSpeciality);
                            }
                          }
                        });
                  });
                },
                isAdd: widget.isPathSelection,
                func: specialityFunc,
              ),
              const SizedBox(height: 16),
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
                        if(widget.isPathSelection){
                          widget.updateFunction(_gradeIndex,selectedGrade);
                        }
                      }
                    });
                  });
                },
                isAdd: widget.isPathSelection,
                func: gradeFunc,
              ),
              const SizedBox(height: 16),
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
                        if(widget.isPathSelection){
                          widget.updateFunction(_subjectIndex,selectedSubject);
                        }
                      }
                    });
                  });
                },
                isAdd: widget.isPathSelection,
                func: subjectFunc,
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: 'Cours',
                items: coursesMap.entries.map((e) => e.value).toList(),
                selectedItem: selectedCours,
                onChanged: (value) {
                  setState(() {
                    selectedCours = value;
                    if(selectedCours != "" && widget.isPathSelection){
                      widget.updateFunction(_coursIndex,selectedCours);
                    }
                  });
                },
                isAdd: widget.isPathSelection,
                func: coursFunc,
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
                style: const TextStyle(
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
        Visibility(visible: !isAdd,child: const SizedBox(width: 15,),),
        Visibility(
          visible: !isAdd,
          child: ElevatedButton(
            onPressed: func,
            child: Icon(Icons.add,size: 30,),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color.fromRGBO(111, 97, 211, 0.5);
                  }
                  else if (states.contains(MaterialState.disabled)){
                    return Colors.grey;
                  }
                  return const Color.fromRGBO(111, 97, 211, 1);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
