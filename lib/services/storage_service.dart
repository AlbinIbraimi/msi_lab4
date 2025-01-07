import 'package:flutter/material.dart';
import 'package:lab_4/models/event.dart';

class StorageServiceProvider extends ChangeNotifier {
  final List<Exam> _exams = [];
  List<Exam> get exams => _exams;

  Future createExam(Exam exam) async {
    // Implement logic to save this exam in firestore or realtime database
    _exams.add(exam);
    notifyListeners();
  }
}
