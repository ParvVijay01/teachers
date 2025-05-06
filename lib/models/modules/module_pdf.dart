class ModulePDF {
  final String id;

  ModulePDF({required this.id});

  factory ModulePDF.fromJson(Map<String, dynamic> json) {
    return ModulePDF(id: json['_id']);
  }
}
