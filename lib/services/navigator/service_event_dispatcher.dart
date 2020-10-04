import 'package:flutter/cupertino.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/navigator/events/push_named.dart';
import 'package:fse/services/navigator/events/push_named_and_replace_all.dart';
import 'package:fse/services/services_event_dispatcher.dart';
import 'package:fse/shared/string_conversions.dart';

enum Navigator_EventType {
  pushNamed,
  pushNamedAndReplaceAll,
}

class Navigator_Event extends ServiceEvent {
  final Navigator_EventType eventType;

  Navigator_Event({
    @required this.eventType,
  }) : super(serviceType: ServiceType.navigator);

  @override
  String toString() {
    return '[${StringConversions.enumValueAsString(serviceType.toString())}] ${StringConversions.enumValueAsString(eventType.toString())}';
  }
}

EventDispatcher navigatorService_EventDispatcher =
    EventDispatcher(dispatcher: (Event _event) async {
  Navigator_Event event = _event as Navigator_Event;

  switch (event.eventType) {
    case Navigator_EventType.pushNamed:
      {
        await pushNamed_Navigator_EventHandler.processEvent(event: event);
      }
      break;
    case Navigator_EventType.pushNamedAndReplaceAll:
      {
        await pushNamedAndReplaceAll_Navigator_EventHandler.processEvent(
            event: event);
      }
      break;
  }
});
