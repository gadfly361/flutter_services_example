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
  @required List<Event> serviceEventsRecorded,
  @required List<Type> serviceEventsExpected,
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
    print('\nEvents expected are not as recorded:');
    print(
        '  serviceEventsExpected length: ${serviceEventsExpected?.length.toString()}');
    print(
        '  serviceEventsRecorded length: ${serviceEventsRecorded?.length.toString()}');
    print('\nserviceEventsExpected vs serviceEventsRecorded:');
    try {
      int idx = 0;
      serviceEventsExpected.forEach((Type _event) {
        print(
            '  ${_event.toString()} == ${serviceEventsRecorded[idx].runtimeType}');
        idx++;
      });
      print('\nserviceEventsRecorded:');
      serviceEventsRecorded.forEach((Event e) {
        print('  ${e.runtimeType.toString()}');
      });
    } catch (_) {}
  }

  serviceEventsRecorded.clear();

  expect(_asExpected, true);
  return;
}
