class ModuleTopics {
  final String id;
  final String subjectTopic;

  ModuleTopics({required this.id, required this.subjectTopic});

  factory ModuleTopics.fromJson(Map<String, dynamic> json) {
    return ModuleTopics(
      id: json['_id'],
      subjectTopic: json['subjectTopic'] 
    );
  }
}
