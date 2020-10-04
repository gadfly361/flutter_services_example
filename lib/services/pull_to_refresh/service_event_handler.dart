import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/services_event_dispatcher.dart';
import 'package:fse/shared/string_conversions.dart';

class PullToRefresh_Event extends ServiceEvent {
  final AsyncCallback onRefresh;

  PullToRefresh_Event({
    @required this.onRefresh,
  }) : super(serviceType: ServiceType.pullToRefresh);

  @override
  String toString() {
    return '[${StringConversions.enumValueAsString(serviceType.toString())}]';
  }
}

EventHandler<void> pullToRefreshService_EventHandler = EventHandler<void>(
  handler: (Event _event) async {
    PullToRefresh_Event event = _event as PullToRefresh_Event;
    await event.onRefresh();
  },
);
