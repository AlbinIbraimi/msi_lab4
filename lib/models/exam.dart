class Exam {
  final String title;
  final DateTime dateTime;
  final String location;

  Exam({
    required this.title,
    required this.dateTime,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
    };
  }

  factory Exam.fromMap(Map<String, dynamic> map) {
    return Exam(
      title: map['title'],
      dateTime: DateTime.parse(map['dateTime']),
      location: map['location'],
    );
  }

  @override
  String toString() {
    return 'Event{title: $title, dateTime: $dateTime, location: $location}';
  }
}
