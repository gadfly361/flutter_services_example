import 'package:meta/meta.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/db/service_event_dispatcher.dart';
import 'package:fse/services/http/service_event_dispatcher.dart';
import 'package:fse/services/navigator/service_event_dispatcher.dart';
import 'package:fse/services/pull_to_refresh/service_event_handler.dart';
import 'package:fse/services/scaffold/service_event_dispatcher.dart';
import 'package:fse/services/shared_preferences/service_event_dispatcher.dart';

enum ServiceType {
  db,
  http,
  navigator,
  pullToRefresh,
  scaffold,
  sharedPreferences,
}

class ServiceEvent extends Event {
  final ServiceType serviceType;

  ServiceEvent({
    @required this.serviceType,
  });
}

EventDispatcher servicesEventDispatcher = EventDispatcher(
  dispatcher: (Event _event) async {
    ServiceEvent event = _event as ServiceEvent;

    switch (event.serviceType) {
      case ServiceType.db:
        {
          await dbService_EventDispatcher.processEvent(event: event);
        }
        break;
      case ServiceType.http:
        {
          await httpService_EventDispatcher.processEvent(event: event);
        }
        break;
      case ServiceType.navigator:
        {
          await navigatorService_EventDispatcher.processEvent(event: event);
        }
        break;
      case ServiceType.pullToRefresh:
        {
          await pullToRefreshService_EventHandler.processEvent(event: event);
        }
        break;
      case ServiceType.scaffold:
        {
          await scaffoldService_EventDispatcher.processEvent(event: event);
        }
        break;
      case ServiceType.sharedPreferences:
        {
          await sharedPreferencesService_EventDispatcher.processEvent(
              event: event);
        }
        break;
    }
  },
);
