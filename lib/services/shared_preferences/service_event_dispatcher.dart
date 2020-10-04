import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/services_event_dispatcher.dart';
import 'package:fse/services/shared_preferences/events/get_string_list.dart';
import 'package:fse/services/shared_preferences/events/set_string_list.dart';
import 'package:fse/shared/string_conversions.dart';

enum SharedPreferences_EventType {
  getStringList,
  setStringList,
}

class SharedPreferences_Event extends ServiceEvent {
  final SharedPreferences_EventType eventType;

  SharedPreferences_Event({
    @required this.eventType,
  }) : super(serviceType: ServiceType.sharedPreferences);

  @override
  String toString() {
    return '[${StringConversions.enumValueAsString(serviceType.toString())}, ${StringConversions.enumValueAsString(eventType.toString())}]';
  }
}

EventDispatcher sharedPreferencesService_EventDispatcher = EventDispatcher(
  dispatcher: (Event _event) async {
    SharedPreferences_Event event = _event as SharedPreferences_Event;

    switch (event.eventType) {
      case SharedPreferences_EventType.getStringList:
        {
          await getStringList_SharedPreferences_EventHandler.processEvent(
              event: event);
        }
        break;
      case SharedPreferences_EventType.setStringList:
        {
          await setStringList_SharedPreferences_EventHandler.processEvent(
              event: event);
        }
        break;
    }
  },
);
