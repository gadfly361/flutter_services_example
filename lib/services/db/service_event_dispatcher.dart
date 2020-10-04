import 'package:flutter/cupertino.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/db/models/navigation/model_event_dispatcher.dart';
import 'package:fse/services/db/models/posts/model_event_dispatcher.dart';
import 'package:fse/services/services_event_dispatcher.dart';

enum DbModel {
  navigation,
  posts,
}

class Db_Event extends ServiceEvent {
  final DbModel dbModel;

  Db_Event({
    @required this.dbModel,
  }) : super(serviceType: ServiceType.db);
}

EventDispatcher dbService_EventDispatcher =
    EventDispatcher(dispatcher: (Event _event) async {
  Db_Event event = _event as Db_Event;

  switch (event.dbModel) {
    case DbModel.navigation:
      {
        await navigation_Db_EventDispatcher.processEvent(event: event);
      }
      break;
    case DbModel.posts:
      {
        await posts_Db_EventDispatcher.processEvent(event: event);
      }
      break;
  }
});
