import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/scaffold/service_event_dispatcher.dart';

class ShowSnackBar_Scaffold_Event extends Scaffold_Event {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final SnackBar snackBar;

  ShowSnackBar_Scaffold_Event({
    @required this.scaffoldKey,
    @required this.snackBar,
  }) : super(eventType: Scaffold_EventType.showSnackBar);

  @override
  String toString() {
    return '${super.toString()} ${scaffoldKey.hashCode.toString()}';
  }
}

EventHandler<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
    showSnackBar_Scaffold_EventHandler =
    EventHandler<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>(
  handler: (Event _event) async {
    ShowSnackBar_Scaffold_Event event = _event as ShowSnackBar_Scaffold_Event;

    return event.scaffoldKey.currentState.showSnackBar(event.snackBar);
  },
);
