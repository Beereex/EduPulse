



class PropositionPath{
  final List<EducationType> education_types;
  PropositionPath({required this.education_types,});
}

class EducationType{
  final String id;
  final String education_type;
  final List<Speciality> specialities_list;

  EducationType({required this.id, required this.education_type, required this.specialities_list,});
}

class Speciality{
  final String id;
  final String speciality;
  final List<Grade> grades_list;

  Speciality({required this.id, required this.speciality, required this.grades_list,});
}

class Grade{
  final String id;
  final String grade;
  final List<Subject> subjects_list;

  Grade({required this.id, required this.grade, required this.subjects_list,});
}

class Subject{
  final String id;
  final String subject;
  final List<Cours> cours_list;

  Subject({required this.id, required this.subject, required this.cours_list,});
}

class Cours{
  final String id;
  final String cours;

  Cours({required this.id, required this.cours,});
}