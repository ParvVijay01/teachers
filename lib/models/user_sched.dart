class User {
  final String id, name, email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['_id'], name: json['name'], email: json['email']);
  }
}
