import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fse/services/db/models/posts/supporting_models/post.dart';

part 'model.g.dart';

@JsonSerializable()
class PostsState {
  static const String favoritePostsById_SharedPreferencesKey =
      'favoritePostsById';

  final List<Post> posts;
  final Post post;
  final Set<int> favoritePostsById;

  PostsState({
    @required this.posts,
    @required this.post,
    @required this.favoritePostsById,
  });

  PostsState copyWith({
    List<Post> posts,
    bool clearPosts = false,
    Post post,
    bool clearPost = false,
    Set<int> favoritePostsById,
    bool clearFavoritePostsById = false,
  }) {
    List<Post> _posts = posts ?? this.posts;
    if (clearPosts) {
      _posts = null;
    }

    Post _post = post ?? this.post;
    if (clearPost) {
      _post = null;
    }

    Set<int> _favoritePostsById = favoritePostsById ?? this.favoritePostsById;
    if (clearFavoritePostsById) {
      _favoritePostsById = null;
    }

    return PostsState(
      post: _post,
      posts: _posts,
      favoritePostsById: _favoritePostsById,
    );
  }

  static PostsState initialState() {
    return PostsState(
      posts: null,
      post: null,
      favoritePostsById: null,
    );
  }

  // boilerplate

  factory PostsState.fromJson(Map<String, dynamic> json) =>
      _$PostsStateFromJson(json);

  Map<String, dynamic> toJson() => _$PostsStateToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsState &&
          runtimeType == other.runtimeType &&
          listEquals<Post>(posts, other.posts) &&
          post == other.post &&
          setEquals<int>(favoritePostsById, other.favoritePostsById);

  @override
  int get hashCode =>
      posts.hashCode ^ post.hashCode ^ favoritePostsById.hashCode;
}
