import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/db/app_db.dart';
import 'package:fse/services/db/models/posts/model_event_dispatcher.dart';
import 'package:fse/services/db/service.dart';

class ToggleFavoritePostById_Posts_Db_Event extends Posts_Db_Event {
  final int postId;

  ToggleFavoritePostById_Posts_Db_Event({
    @required this.postId,
  }) : super(eventType: Posts_Db_EventType.toggleFavoritePostById);
}

EventHandler<Set<int>> toggleFavoritePostById_Posts_Db_EventHandler =
    EventHandler<Set<int>>(
  handler: (Event _event) async {
    ToggleFavoritePostById_Posts_Db_Event event =
        _event as ToggleFavoritePostById_Posts_Db_Event;

    AppDb appDbOld = GetIt.I<AppDb>();
    Set<int> _favoritePostsById =
        Set<int>.from(appDbOld.postsState?.favoritePostsById ?? <int>{});

    if (_favoritePostsById.contains(event.postId)) {
      _favoritePostsById.remove(event.postId);
    } else {
      _favoritePostsById.add(event.postId);
    }

    AppDb appDbNew = appDbOld.copyWith(
      postsState: appDbOld.postsState.copyWith(
        favoritePostsById: _favoritePostsById,
        clearPost: _favoritePostsById == null,
      ),
    );

    GetIt.I<DbService>().updateDbStream(appDbNew);

    return _favoritePostsById;
  },
);
