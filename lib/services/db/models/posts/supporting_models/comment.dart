import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final String body;
  final String email;
  final int id;
  final String name;
  final int postId;

  Comment({
    @required this.body,
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.postId,
  });

  // boilerplate

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          body == other.body &&
          email == other.email &&
          id == other.id &&
          name == other.name &&
          postId == other.postId;

  @override
  int get hashCode =>
      body.hashCode ^
      email.hashCode ^
      id.hashCode ^
      name.hashCode ^
      postId.hashCode;
}
