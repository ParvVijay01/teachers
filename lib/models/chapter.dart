class Chapter {
  final String id;
  final String chapterName;

  Chapter({required this.id, required this.chapterName});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['_id'],
      chapterName: json['chapterName'],
    );
  }
}