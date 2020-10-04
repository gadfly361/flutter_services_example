import 'package:meta/meta.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/db/models/posts/events/set_favorite_post_ids_from_string_list.dart';
import 'package:fse/services/db/models/posts/events/set_post.dart';
import 'package:fse/services/db/models/posts/events/set_posts.dart';
import 'package:fse/services/db/models/posts/events/toggle_favorite_post_by_id.dart';
import 'package:fse/services/db/service_event_dispatcher.dart';
import 'package:fse/shared/string_conversions.dart';

enum Posts_Db_EventType {
  setPosts,
  setPost,
  toggleFavoritePostById,
  setFavoritePostIdsFromStringList,
}

class Posts_Db_Event extends Db_Event {
  final Posts_Db_EventType eventType;

  Posts_Db_Event({
    @required this.eventType,
  }) : super(dbModel: DbModel.posts);

  @override
  String toString() {
    final String serviceTypeAsString =
        StringConversions.enumValueAsString(serviceType.toString());
    final String dbModelAsString =
        StringConversions.enumValueAsString(dbModel.toString());
    final String eventTypeAsString =
        StringConversions.enumValueAsString(eventType.toString());

    return '[$serviceTypeAsString, $dbModelAsString] $eventTypeAsString';
  }
}

EventDispatcher posts_Db_EventDispatcher =
    EventDispatcher(dispatcher: (Event _event) async {
  Posts_Db_Event event = _event as Posts_Db_Event;
  switch (event.eventType) {
    case Posts_Db_EventType.setPosts:
      {
        await setPosts_Posts_Db_EventHandler.processEvent(event: event);
      }
      break;
    case Posts_Db_EventType.setPost:
      {
        await setPost_Posts_Db_EventHandler.processEvent(event: event);
      }
      break;
    case Posts_Db_EventType.toggleFavoritePostById:
      {
        await toggleFavoritePostById_Posts_Db_EventHandler.processEvent(
            event: event);
      }
      break;
    case Posts_Db_EventType.setFavoritePostIdsFromStringList:
      {
        await setFavoritePostIdsFromStringList_Posts_Db_EventHandler
            .processEvent(event: event);
      }
      break;
  }
});
