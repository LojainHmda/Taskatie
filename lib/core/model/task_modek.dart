class Task {
  final String title;
  final String id;
  final String note;
  final String startTime;
  final String endTime;
  final String date;
  final int color;
  bool isComplete;

  Task({
    required this.title,
    required this.id,
    required this.note,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.isComplete,
    required this.color,
  });
}
