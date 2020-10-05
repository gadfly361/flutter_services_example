import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/services/services_event_dispatcher.dart';

List<Event> startRecordingServiceEvents() {
  List<Event> _serviceEventsRecorded = <Event>[];
  servicesEventDispatcher.addBeforeEventCallback((Event event) async {
    _serviceEventsRecorded.add(event);
  });
  return _serviceEventsRecorded;
}

void areServiceEventsInExpectedOrder({
  @required List<Type> serviceEventsExpected,
  @required List<Event> serviceEventsRecorded,
}) {
  bool _asExpected = false;
  try {
    if (serviceEventsExpected?.length == serviceEventsRecorded?.length) {
      int idx = 0;
      _asExpected = serviceEventsExpected.every((Type _event) {
        bool _eventIsExpected =
            _event == serviceEventsRecorded[idx].runtimeType;
        idx++;
        return _eventIsExpected;
      });
    } else {
      _asExpected = false;
    }
  } catch (_) {
    _asExpected = false;
  }
  if (!_asExpected) {
    print('\nEvents are not as expected:');
    print(
        '  serviceEventsExpected length: ${serviceEventsExpected?.length.toString()}');
    print(
        '  serviceEventsRecorded length: ${serviceEventsRecorded?.length.toString()}');
    try {
      int idx = 0;
      serviceEventsExpected.forEach((Type _event) {
        print(
            '    ${_event.toString()} == ${serviceEventsRecorded[idx].runtimeType}');
        idx++;
      });
    } catch (_) {}
  }

  serviceEventsRecorded.clear();

  expect(_asExpected, true);
  return;
}
