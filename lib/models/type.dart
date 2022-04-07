class Type {
  final int? id;
  final String? name;

  Type({this.id, this.name});

  Type.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        name = jsonMap['name'] ?? '';
}
