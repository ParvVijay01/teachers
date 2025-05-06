class Batches {
  final String id;
  final String className;

  Batches({required this.id, required this.className});

  factory Batches.fromJson(Map<String, dynamic> json) {
    return Batches(
      id: json['_id'],
      className: json['className'] 
    );
  }
}
