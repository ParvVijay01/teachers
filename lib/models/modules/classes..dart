class Classes {
  final String id;
  final String className;

  Classes({required this.id, required this.className});

  factory Classes.fromJson(Map<String, dynamic> json) {
    return Classes(
      id: json['_id'],
      className: json['className'] 
    );
  }
}
