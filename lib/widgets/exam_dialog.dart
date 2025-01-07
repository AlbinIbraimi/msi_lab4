import 'package:flutter/material.dart';
import 'package:lab_4/models/exam.dart';
import 'package:lab_4/services/storage_service.dart';
import 'package:lab_4/widgets/location_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CreateExamDialog extends StatefulWidget {
  const CreateExamDialog({super.key});

  @override
  State<CreateExamDialog> createState() => _CreateExamDialogState();
}

class _CreateExamDialogState extends State<CreateExamDialog> {
  final TextEditingController titleController = TextEditingController();
  LatLng? selectedLocation;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<StorageServiceProvider>(context, listen: false);

    return AlertDialog(
      title: const Text('Add Exam'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Exam Title'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedLocation != null
                    ? const Row(
                        children: [
                          Text('Location'),
                          SizedBox(width: 8),
                          Icon(Icons.check, color: Colors.green),
                        ],
                      )
                    : const Text('Location'),
                TextButton(
                  onPressed: () async {
                    final LatLng? pickedLocation = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LocationPicker(initialLocation: selectedLocation),
                      ),
                    );

                    if (pickedLocation != null) {
                      setState(() {
                        selectedLocation = pickedLocation;
                      });
                    }
                  },
                  child: Text(
                    selectedLocation != null
                        ? 'Change Location'
                        : 'Pick Location',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
                TextButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: const Text('Select Date'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Time: ${selectedTime.format(context)}'),
                TextButton(
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (picked != null && picked != selectedTime) {
                      setState(() {
                        selectedTime = picked;
                      });
                    }
                  },
                  child: const Text('Select Time'),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (titleController.text.isNotEmpty && selectedLocation != null) {
              final newExam = Exam(
                title: titleController.text,
                dateTime: DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                ),
                location: selectedLocation,
              );
              storage.createExam(newExam);
              Navigator.pop(context); // Close the dialog
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill in all fields!')),
              );
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
