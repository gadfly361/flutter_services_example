import 'dart:io';

import 'package:fse/builds/prep_build.dart';
import 'package:fse/framework/services.dart';
import 'package:fse/services/db/service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAppHttpClient extends Mock implements http.Client {}

class AppFixture {
  static Future<void> setUp() async {
    SharedPreferences.setMockInitialValues(<String, dynamic>{});
    prepBuild(httpClient: MockAppHttpClient());
  }

  static Future<void> tearDown() async {
    await GetIt.I<DbService>().closeDbStream();
    await GetIt.I<Services>().closeEventStream();
    await GetIt.I.reset();
  }
}

Map<String, String> defaultJsonHeaders = <String, String>{
  HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
};
