class Centers {
  final String id;
  final String name;

  Centers({required this.id, required this.name});

  factory Centers.fromJson(Map<String, dynamic> json) {
    return Centers(id: json['_id'], name: json['name']);
  }
}
