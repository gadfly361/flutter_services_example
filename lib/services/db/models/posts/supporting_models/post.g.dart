// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    body: json['body'] as String,
    comments: (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as int,
    title: json['title'] as String,
    userId: json['userId'] as int,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'body': instance.body,
      'id': instance.id,
      'title': instance.title,
      'userId': instance.userId,
      'comments': instance.comments,
    };
