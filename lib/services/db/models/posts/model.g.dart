// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostsState _$PostsStateFromJson(Map<String, dynamic> json) {
  return PostsState(
    posts: (json['posts'] as List)
        ?.map(
            (e) => e == null ? null : Post.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    post: json['post'] == null
        ? null
        : Post.fromJson(json['post'] as Map<String, dynamic>),
    favoritePostsById:
        (json['favoritePostsById'] as List)?.map((e) => e as int)?.toSet(),
  );
}

Map<String, dynamic> _$PostsStateToJson(PostsState instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'post': instance.post,
      'favoritePostsById': instance.favoritePostsById?.toList(),
    };
