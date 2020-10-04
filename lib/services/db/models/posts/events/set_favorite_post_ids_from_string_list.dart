import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/db/app_db.dart';
import 'package:fse/services/db/models/posts/model_event_dispatcher.dart';
import 'package:fse/services/db/service.dart';

class SetFavoritePostIdsFromStringList_Posts_Db_Event extends Posts_Db_Event {
  final List<String> stringList;

  SetFavoritePostIdsFromStringList_Posts_Db_Event({
    @required this.stringList,
  }) : super(eventType: Posts_Db_EventType.setFavoritePostIdsFromStringList);
}

EventHandler<Set<int>> setFavoritePostIdsFromStringList_Posts_Db_EventHandler =
    EventHandler<Set<int>>(
  handler: (Event _event) async {
    SetFavoritePostIdsFromStringList_Posts_Db_Event event =
        _event as SetFavoritePostIdsFromStringList_Posts_Db_Event;

    AppDb appDbOld = GetIt.I<AppDb>();
    List<int> intList = event.stringList?.map((String intAsString) => int.parse(intAsString))?.toList();
    Set<int> _favoritePostsById = Set<int>.from(intList ?? <int>{});

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
