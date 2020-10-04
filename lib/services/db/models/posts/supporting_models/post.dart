import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fse/services/db/models/posts/supporting_models/comment.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final String body;
  final int id;
  final String title;
  final int userId;
  final List<Comment> comments;

  Post({
    @required this.body,
    this.comments,
    @required this.id,
    @required this.title,
    @required this.userId,
  });

  Post copyWithComments(
    List<Comment> comments,
  ) {
    return Post(
      body: body,
      comments: comments,
      id: id,
      title: title,
      userId: userId,
    );
  }

  // boilerplate

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post &&
          runtimeType == other.runtimeType &&
          body == other.body &&
          id == other.id &&
          title == other.title &&
          userId == other.userId &&
          listEquals<Comment>(comments, other.comments);

  @override
  int get hashCode =>
      body.hashCode ^
      id.hashCode ^
      title.hashCode ^
      userId.hashCode ^
      comments.hashCode;
}
