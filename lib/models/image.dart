class Image {
  final int? id;
  final String? name;
  final String? size;
  final int? property_id;
  final int? user_id;
  final String? image_base64;

  Image({
    this.id,
    this.name,
    this.size,
    this.property_id,
    this.user_id,
    this.image_base64,
  });

  Image.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        name = jsonMap['name'],
        size = jsonMap['size'],
        property_id = jsonMap['property_id'],
        user_id = jsonMap['user_id'],
        image_base64 = jsonMap['img_base64'];
}
