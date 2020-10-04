import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/http/service.dart';
import 'package:fse/services/http/service_event_dispatcher.dart';

class Get_Http_Event extends Http_Event {
  final String url;
  final Map<String, String> headers;

  Get_Http_Event({
    @required this.url,
    this.headers,
  }) : super(eventType: Http_EventType.get);

  @override
  String toString() {
    return '${super.toString()} $url';
  }
}

EventHandler<http.Response> get_Http_EventHandler = EventHandler<http.Response>(
  handler: (Event _event) async {
    Get_Http_Event event = _event as Get_Http_Event;

    http.Response response = await GetIt.I<HttpService>().httpClient.get(
          event.url,
          headers: event.headers,
        );

    return response;
  },
);
