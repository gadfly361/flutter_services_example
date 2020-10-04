import 'package:get_it/get_it.dart';
import 'package:fse/framework/services.dart';
import 'package:fse/services/db/service.dart';
import 'package:fse/services/http/service.dart';
import 'package:fse/services/navigator/service.dart';
import 'package:fse/services/services_event_dispatcher.dart';

void initServices() {
  // Services
  GetIt.I.registerSingleton<Services>(
      Services(eventProcessor: servicesEventDispatcher));
  GetIt.I<Services>().startEventStream();

  // DbService
  GetIt.I.registerSingleton<DbService>(DbService());
  GetIt.I<DbService>().initService();

  // HttpService
  GetIt.I.registerSingleton<HttpService>(HttpService());

  // NavigatorService
  GetIt.I.registerSingleton<NavigatorService>(NavigatorService());
}
