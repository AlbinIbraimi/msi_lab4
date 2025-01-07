import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/marked_date.dart';
import 'package:flutter_calendar_carousel/classes/multiple_marked_dates.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:lab_4/services/storage_service.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDate = DateTime.now();

  DateTime normalizedDate(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<StorageServiceProvider>(context);
    final eventDates = storage.exams
        .map((item) => MarkedDate(
              date: normalizedDate(item.dateTime),
              color: Colors.red,
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: CalendarCarousel(
                onDayPressed: (DateTime date, List events) {
                  setState(() {
                    _selectedDate = date;
                    Navigator.pushNamed(context, '/detailes');
                  });
                },
                thisMonthDayBorderColor: Colors.transparent,
                selectedDayButtonColor: Colors.grey,
                todayBorderColor: Colors.blue,
                todayButtonColor: Colors.blueAccent,
                multipleMarkedDates: MultipleMarkedDates(
                  markedDates: eventDates,
                ),
                markedDateShowIcon: true,
                markedDateIconMaxShown: 1,
                markedDateIconBuilder: (event) {
                  return const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 12.0,
                  );
                },
                selectedDateTime: _selectedDate,
                daysHaveCircularBorder: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
