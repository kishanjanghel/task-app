class NotificationModel {
  final String title;
  final String body;
  final DateTime dateTime;

  NotificationModel({
    required this.title,
    required this.body,
    required this.dateTime,
  });
}

final List<NotificationModel> dummyNotifications = [
  NotificationModel(
    title: "Class Update",
    body: "Maths class will start at 10:30 AM instead of 10:00 AM.",
    dateTime: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  NotificationModel(
    title: "New Assignment",
    body: "Science assignment has been uploaded. Please check.",
    dateTime: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  NotificationModel(
    title: "Timetable Changed",
    body: "Your timetable for Friday has been updated.",
    dateTime: DateTime.now().subtract(const Duration(days: 1)),
  ),
];
