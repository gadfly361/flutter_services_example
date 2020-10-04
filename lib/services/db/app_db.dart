import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:fse/services/db/models/navigation/model.dart';
import 'package:fse/services/db/models/posts/model.dart';

part 'app_db.g.dart';

@JsonSerializable()
class AppDb {
  final NavigationState navigationState;
  final PostsState postsState;

  AppDb({
    @required this.navigationState,
    @required this.postsState,
  });

  AppDb copyWith({
    NavigationState navigationState,
    PostsState postsState,
  }) {
    return AppDb(
      navigationState: navigationState ?? this.navigationState,
      postsState: postsState ?? this.postsState,
    );
  }

  static AppDb initialState() {
    return AppDb(
      navigationState: NavigationState.initialState(),
      postsState: PostsState.initialState(),
    );
  }

  // boilerplate

  factory AppDb.fromJson(Map<String, dynamic> json) => _$AppDbFromJson(json);

  Map<String, dynamic> toJson() => _$AppDbToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppDb &&
          runtimeType == other.runtimeType &&
          navigationState == other.navigationState &&
          postsState == other.postsState;

  @override
  int get hashCode => navigationState.hashCode ^ postsState.hashCode;
}
