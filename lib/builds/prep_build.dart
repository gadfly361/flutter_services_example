import 'package:fse/services/init_services.dart';
import 'package:http/http.dart' as http;

void prepBuild({
  http.Client httpClient,
}) {
  initServices(httpClient: httpClient);
}
