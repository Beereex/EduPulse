


import 'package:cloud_firestore/cloud_firestore.dart';

class Vote{
  int vote;
  Timestamp date;
  String propositionId;
  String propositionTitle;

  Vote({
    required this.vote,
    required this.date,
    required this.propositionId,
    required this.propositionTitle,
  });
}