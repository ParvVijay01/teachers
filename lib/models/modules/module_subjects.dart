class ModuleSubjects {
  final String id;
  final String subjectName;

  ModuleSubjects({required this.id, required this.subjectName});

  factory ModuleSubjects.fromJson(Map<String, dynamic> json) {
    return ModuleSubjects(
      id: json['_id'],
      subjectName: json['subjectName'] 
    );
  }
}
