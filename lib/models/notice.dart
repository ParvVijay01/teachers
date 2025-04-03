class Notice {
  final String id, name, secureUrl;

  Notice({required this.id, required this.name, required this.secureUrl});

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['_id'],
      name: json['name'],
      secureUrl: json['secure_url'],
    );
  }
}
