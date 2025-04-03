import 'package:teachers_app/models/chapter.dart';

class Subject {
  final String id;
  final String subjectName;
  final List<Chapter> chapters;

  Subject({required this.id, required this.subjectName, required this.chapters});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'],
      subjectName: json['subjectName'],
      chapters: (json['chapters'] as List)
          .map((chapter) => Chapter.fromJson(chapter))
          .toList(),
    );
  }
}