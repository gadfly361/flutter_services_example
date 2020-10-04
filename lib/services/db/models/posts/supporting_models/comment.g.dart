// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    body: json['body'] as String,
    email: json['email'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    postId: json['postId'] as int,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'body': instance.body,
      'email': instance.email,
      'id': instance.id,
      'name': instance.name,
      'postId': instance.postId,
    };
