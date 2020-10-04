import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/navigator/service.dart';
import 'package:fse/services/navigator/service_event_dispatcher.dart';

class PushNamedAndReplaceAll_Navigator_Event extends Navigator_Event {
  final AppRoute appRoute;

  PushNamedAndReplaceAll_Navigator_Event({
    @required this.appRoute,
  }) : super(eventType: Navigator_EventType.pushNamedAndReplaceAll);
}

EventHandler<void> pushNamedAndReplaceAll_Navigator_EventHandler =
    EventHandler<void>(
  handler: (Event _event) async {
    PushNamedAndReplaceAll_Navigator_Event event =
        _event as PushNamedAndReplaceAll_Navigator_Event;

    final NavigatorService navigatorService = GetIt.I<NavigatorService>();

    /// Note: we are intentionally not awaiting this future,
    /// because it would wait until the page pops
    ///
    /// ignore: unawaited_futures
    navigatorService.appNavigatorKey.currentState
        .pushNamedAndRemoveUntil(event.appRoute.toString(), (_) => false);

    return;
  },
);
