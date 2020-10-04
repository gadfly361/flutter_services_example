import 'package:flutter/cupertino.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/http/events/get.dart';
import 'package:fse/services/services_event_dispatcher.dart';
import 'package:fse/shared/string_conversions.dart';

enum Http_EventType {
  get,
}

class Http_Event extends ServiceEvent {
  final Http_EventType eventType;

  Http_Event({
    @required this.eventType,
  }) : super(serviceType: ServiceType.http);

  @override
  String toString() {
    return '[${StringConversions.enumValueAsString(serviceType.toString())}, ${StringConversions.enumValueAsString(eventType.toString())}]';
  }
}

EventDispatcher httpService_EventDispatcher =
    EventDispatcher(dispatcher: (Event _event) async {
  Http_Event event = _event as Http_Event;

  switch (event.eventType) {
    case Http_EventType.get:
      {
        await get_Http_EventHandler.processEvent(event: event);
      }
      break;
  }
});
