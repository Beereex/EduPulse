import 'package:cloud_firestore/cloud_firestore.dart';

class PropositionPath {
  final List<EducationType> educationTypes;

  PropositionPath({required this.educationTypes});
}

class EducationType {
  final String id;
  final String educationType;
  final List<Speciality> specialitiesList;

  EducationType({
    required this.id,
    required this.educationType,
    required this.specialitiesList,
  });
}

class Speciality {
  final String id;
  final String speciality;
  final List<Grade> gradesList;

  Speciality({
    required this.id,
    required this.speciality,
    required this.gradesList,
  });
}

class Grade {
  final String id;
  final String grade;
  final List<Subject> subjectsList;

  Grade({
    required this.id,
    required this.grade,
    required this.subjectsList,
  });
}

class Subject {
  final String id;
  final String subject;
  final List<String> coursList;

  Subject({
    required this.id,
    required this.subject,
    required this.coursList,
  });
}

class Cours {
  final String id;
  final String cours;

  Cours({
    required this.id,
    required this.cours,
  });
}

Future<PropositionPath> fetchPropositionPath(FirebaseFirestore firestore) async {
  final typesMap = await fillTypes(firestore);
  final typesList = typesMap.entries
      .map((entry) => EducationType(
    id: entry.key,
    educationType: entry.value,
    specialitiesList: [],
  ))
      .toList();

  return PropositionPath(educationTypes: typesList);
}

Future<void> populateSpecialities(
    FirebaseFirestore firestore,
    EducationType educationType,
    ) async {
  final specialitiesMap =
  await fillSpecialities(firestore, educationType.id);
  final specialitiesList = specialitiesMap.entries
      .map((entry) => Speciality(
    id: entry.key,
    speciality: entry.value,
    gradesList: [],
  ))
      .toList();

  educationType.specialitiesList.clear();
  educationType.specialitiesList.addAll(specialitiesList);
}

Future<void> populateGrades(
    FirebaseFirestore firestore,
    Speciality speciality,
    ) async {
  final gradesMap =
  await fillGrades(firestore, speciality.id);
  final gradesList = gradesMap.entries
      .map((entry) => Grade(
    id: entry.key,
    grade: entry.value,
    subjectsList: [],
  ))
      .toList();

  speciality.gradesList.clear();
  speciality.gradesList.addAll(gradesList);
}

Future<void> populateSubjects(
    FirebaseFirestore firestore,
    Grade grade,
    ) async {
  final subjectsMap =
  await fillSubjects(firestore, grade.id);
  final subjectsList = subjectsMap.entries
      .map((entry) => Subject(
    id: entry.key,
    subject: entry.value,
    coursList: [],
  ))
      .toList();

  grade.subjectsList.clear();
  grade.subjectsList.addAll(subjectsList);
}

Future<void> populateCourses(
    FirebaseFirestore firestore,
    Subject subject,
    ) async {
  final coursesList =
  await fillCourses(firestore, subject.id);

  subject.coursList.clear();
  subject.coursList.addAll(coursesList);
}

Future<Map<String, String>> fillTypes(FirebaseFirestore firestore) async {
  final typesQuery = await firestore.collection('educationTypes').get();
  final typesMap = <String, String>{};

  for (final doc in typesQuery.docs) {
    typesMap[doc.id] = doc['education_type'] as String;
  }

  return typesMap;
}

Future<Map<String, String>> fillSpecialities(
    FirebaseFirestore firestore, String educationTypeId) async {
  final specialitiesQuery = await firestore
      .collection('educationTypes/$educationTypeId/specialities')
      .get();
  final specialitiesMap = <String, String>{};

  for (final doc in specialitiesQuery.docs) {
    specialitiesMap[doc.id] = doc['speciality'] as String;
  }

  return specialitiesMap;
}

Future<Map<String, String>> fillGrades(
    FirebaseFirestore firestore, String specialityId) async {
  final gradesQuery = await firestore
      .collection('educationTypes/$specialityId/grades')
      .get();
  final gradesMap = <String, String>{};

  for (final doc in gradesQuery.docs) {
    gradesMap[doc.id] = doc['grade'] as String;
  }

  return gradesMap;
}

Future<Map<String, String>> fillSubjects(
    FirebaseFirestore firestore, String gradeId) async {
  final subjectsQuery = await firestore
      .collection('educationTypes/$gradeId/subjects')
      .get();
  final subjectsMap = <String, String>{};

  for (final doc in subjectsQuery.docs) {
    subjectsMap[doc.id] = doc['subject'] as String;
  }

  return subjectsMap;
}

Future<List<String>> fillCourses(
    FirebaseFirestore firestore, String subjectId) async {
  final coursesQuery = await firestore
      .collection('educationTypes/$subjectId/cours')
      .get();
  final coursesList = <String>[];

  for (final doc in coursesQuery.docs) {
    coursesList.add(doc['cours'] as String);
  }

  return coursesList;
}
