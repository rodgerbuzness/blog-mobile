import 'package:blog_app/models/user.dart';

class Post {
  int? id;
  String? body;
  String? photo;
  int? likescount;
  int? commentsCount;
  User? user;
  bool? selfLiked;

  Post({
    this.id,
    this.body,
    this.photo,
    this.likescount,
    this.commentsCount,
    this.user,
    this.selfLiked,
  });

// map json to post model
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        body: json['desc'],
        photo: json['photo'],
        likescount: json['likes_count'],
        commentsCount: json['comments_count'],
        selfLiked: json['likes'].length > 0,
        user: User(
          id: json['user']['id'],
          name: json['user']['name'],
          photo: json['user']['image'],
        ));
  }
}
