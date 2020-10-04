import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/db/app_db.dart';
import 'package:fse/services/db/models/posts/model_event_dispatcher.dart';
import 'package:fse/services/db/models/posts/supporting_models/post.dart';
import 'package:fse/services/db/service.dart';

class SetPost_Posts_Db_Event extends Posts_Db_Event {
  final Post post;

  SetPost_Posts_Db_Event({
    @required this.post,
  }) : super(eventType: Posts_Db_EventType.setPost);
}

EventHandler<Post> setPost_Posts_Db_EventHandler = EventHandler<Post>(
  handler: (Event _event) async {
    SetPost_Posts_Db_Event event = _event as SetPost_Posts_Db_Event;

    AppDb appDbOld = GetIt.I<AppDb>();

    AppDb appDbNew = appDbOld.copyWith(
      postsState: appDbOld.postsState.copyWith(
        post: event.post,
        clearPost: event.post == null,
      ),
    );

    GetIt.I<DbService>().updateDbStream(appDbNew);

    return event.post;
  },
);
