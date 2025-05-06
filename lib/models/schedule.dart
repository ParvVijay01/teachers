import 'package:LNP_Guru/models/user_sched.dart';

class Schedules {
  final String id, subjectName, chapterName, topic, date, className, centerName;
  final User userId;

  Schedules({
    required this.id,
    required this.subjectName,
    required this.chapterName,
    required this.topic,
    required this.date,
    required this.userId,
    required this.className,
    required this.centerName,
  });

  factory Schedules.fromJson(Map<String, dynamic> json) {
    return Schedules(
      id: json['_id'],
      subjectName: json['subjectName'],
      chapterName: json['chapterName'],
      topic: json['topic'],
      date: json['date'],
      className: json['className'] ?? "BATCH",
      userId: User.fromJson(json['userId']),
      centerName: json['centerName'] ?? "Center Name",
    );
  }
}
