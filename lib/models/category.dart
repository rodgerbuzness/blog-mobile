class Category {
  final int? id;
  final String? name;

  Category({
    this.id,
    this.name,
  });

  Category.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        name = jsonMap['name'] ?? '';
}
