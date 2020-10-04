import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/shared_preferences/service_event_dispatcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStringList_SharedPreferences_Event extends SharedPreferences_Event {
  final String key;

  GetStringList_SharedPreferences_Event({
    @required this.key,
  }) : super(eventType: SharedPreferences_EventType.getStringList);

  @override
  String toString() {
    return '${super.toString()} $key';
  }
}

EventHandler<List<String>> getStringList_SharedPreferences_EventHandler =
    EventHandler<List<String>>(
  handler: (Event _event) async {
    GetStringList_SharedPreferences_Event event =
        _event as GetStringList_SharedPreferences_Event;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getStringList(event.key);
  },
);
