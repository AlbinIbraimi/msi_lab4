import 'package:flutter/material.dart';
import 'package:lab_4/widgets/exam_dialog.dart';
import 'package:lab_4/widgets/exams_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CreateExamDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ExamsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {showAddEventDialog(context)},
        tooltip: 'Add Exam',
        child: const Icon(Icons.add),
      ),
    );
  }
}
