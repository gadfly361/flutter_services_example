import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:fse/framework/services.dart';
import 'package:fse/services/db/service.dart';
import 'package:fse/services/http/service.dart';
import 'package:fse/services/navigator/service.dart';
import 'package:fse/services/services_event_dispatcher.dart';

void initServices({
  http.Client httpClient,
}) {
  // Services
  GetIt.I.registerSingleton<Services>(
      Services(eventProcessor: servicesEventDispatcher));
  GetIt.I<Services>().startEventStream();

  // DbService
  GetIt.I.registerSingleton<DbService>(DbService());
  GetIt.I<DbService>().initService();

  // HttpService
  GetIt.I.registerSingleton<HttpService>(HttpService());
  GetIt.I<HttpService>().httpClient = httpClient ?? http.Client();

  // NavigatorService
  GetIt.I.registerSingleton<NavigatorService>(NavigatorService());
}
