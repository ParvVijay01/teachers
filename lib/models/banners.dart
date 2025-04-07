class Banners {
  final String id, secureUrl, name;

  Banners({required this.id, required this.secureUrl, required this.name});

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      id: json['_id'],
      name: json['name'],
      secureUrl: json['secure_url']
    );
  }
}
