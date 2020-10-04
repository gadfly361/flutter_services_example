import 'package:meta/meta.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/scaffold/events/show_snack_bar.dart';
import 'package:fse/services/services_event_dispatcher.dart';
import 'package:fse/shared/string_conversions.dart';

enum Scaffold_EventType {
  showSnackBar,
}

class Scaffold_Event extends ServiceEvent {
  final Scaffold_EventType eventType;

  Scaffold_Event({
    @required this.eventType,
  }) : super(serviceType: ServiceType.scaffold);

  @override
  String toString() {
    return '[${StringConversions.enumValueAsString(serviceType.toString())}] ${StringConversions.enumValueAsString(eventType.toString())}';
  }
}

EventDispatcher scaffoldService_EventDispatcher =
    EventDispatcher(dispatcher: (Event _event) async {
  Scaffold_Event event = _event as Scaffold_Event;

  switch (event.eventType) {
    case Scaffold_EventType.showSnackBar:
      {
        await showSnackBar_Scaffold_EventHandler.processEvent(event: event);
      }
      break;
  }
});
