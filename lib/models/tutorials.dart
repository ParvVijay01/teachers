class Tutorial {
  final String id;
  final String title, secureUrl;

  Tutorial({required this.id, required this.title, required this.secureUrl});

  factory Tutorial.fromJson(Map<String, dynamic> json) {
    return Tutorial(
      id: json['_id'],
      title: json['className'],
      secureUrl: json['secure_url'] 
    );
  }
}