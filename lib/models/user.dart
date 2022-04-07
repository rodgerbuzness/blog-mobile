class User {
  int? id;
  String? name;
  String? photo;
  String? email;
  String? token;

  User({this.id, this.name, this.email, this.photo, this.token});

  // function to convert json data to user model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      photo: json['user']['photo'],
      email: json['user']['email'],
      token: json['token'],
    );
  }
}
