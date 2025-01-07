import 'package:flutter/material.dart';
import 'package:lab_4/services/storage_service.dart';
import 'package:provider/provider.dart';

class ExamsList extends StatefulWidget {
  const ExamsList({super.key});

  @override
  State<ExamsList> createState() => _ExamsListState();
}

class _ExamsListState extends State<ExamsList> {
  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<StorageServiceProvider>(context);

    return Scaffold(
      body: ListView.builder(
        itemCount: storage.exams.length,
        itemBuilder: (context, index) {
          final event = storage.exams[index];

          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(event.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${event.dateTime.toLocal()}'),
                  Text('Location: ${event.location}'),
                ],
              ),
              trailing: const Icon(Icons.event, color: Colors.blue),
              onTap: () {
                // Navigate to event details screen if needed
              },
            ),
          );
        },
      ),
    );
  }
}
