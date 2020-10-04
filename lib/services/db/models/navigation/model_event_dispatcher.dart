import 'package:meta/meta.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/db/models/navigation/events/set_bottom_navigation_bar_index.dart';
import 'package:fse/services/db/service_event_dispatcher.dart';
import 'package:fse/shared/string_conversions.dart';

enum Navigation_Db_EventType {
  setBottomNavigationBarIndex,
}

class Navigation_Db_Event extends Db_Event {
  final Navigation_Db_EventType eventType;

  Navigation_Db_Event({
    @required this.eventType,
  }) : super(dbModel: DbModel.navigation);

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

EventDispatcher navigation_Db_EventDispatcher =
    EventDispatcher(dispatcher: (Event _event) async {
  Navigation_Db_Event event = _event as Navigation_Db_Event;

  switch (event.eventType) {
    case Navigation_Db_EventType.setBottomNavigationBarIndex:
      {
        await setBottomNavigationBarIndex_Navigation_Db_EventHandler
            .processEvent(event: event);
      }
      break;
  }
});
