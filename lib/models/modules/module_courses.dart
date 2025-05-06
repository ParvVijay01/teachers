class ModuleCourses {
  final String id;
  final String courseName;

  ModuleCourses({required this.id, required this.courseName});

  factory ModuleCourses.fromJson(Map<String, dynamic> json) {
    return ModuleCourses(
      id: json['_id'],
      courseName: json['courseName'] 
    );
  }
}
