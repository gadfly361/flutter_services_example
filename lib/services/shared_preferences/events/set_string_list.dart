import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/shared_preferences/service_event_dispatcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetStringList_SharedPreferences_Event extends SharedPreferences_Event {
  final List<String> stringList;
  final String key;

  SetStringList_SharedPreferences_Event({
    @required this.key,
    @required this.stringList,
  }) : super(eventType: SharedPreferences_EventType.setStringList);

  @override
  String toString() {
    return '${super.toString()} $key, length: ${stringList.length}';
  }
}

EventHandler<bool> setStringList_SharedPreferences_EventHandler =
    EventHandler<bool>(
  handler: (Event _event) async {
    SetStringList_SharedPreferences_Event event =
        _event as SetStringList_SharedPreferences_Event;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setStringList(event.key, event.stringList);
  },
);
