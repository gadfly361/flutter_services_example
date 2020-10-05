import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'async_event_result.dart';
import 'event_processor.dart';
import 'event.dart';

class Services {
  /// The events are pumped through a [StreamController] that we will
  /// refer to as en [_eventStream]. We can listen to this event stream
  /// and handle any incoming event with a callback, the [_eventProcessor].
  StreamController<Event> _eventStream;
  final EventProcessor _eventProcessor;

  Services({
    @required EventProcessor eventProcessor,
  }) : _eventProcessor = eventProcessor;

  void startEventStream() {
    debugPrint('starting event stream');

    _eventStream = StreamController<Event>(sync: false);
    _eventStream.stream.listen((Event event) async {
      await _eventProcessor.processEvent(event: event);
    });
  }

  Future<void> closeEventStream() async {
    if (!(_eventStream?.isClosed ?? true)) {
      debugPrint('closing event stream');
      await _eventStream.close();
      _eventStream = null;
    }
  }

  Future<R> dispatchAsyncEvent<R>({
    @required Event event,
    Duration timeout,
    AsyncCallback onTimeout,
    AsyncValueSetter<Object> onError,
  }) async {
    event.completer = Completer<AsyncEventResult<R>>();
    _eventStream.add(event);
    AsyncEventResult<R> result;

    /// If
    /// - a timeout is specified,
    /// - the timeout has been reached, and
    /// - the completer is not yet complete,
    /// then complete the completer and set the result status to timeout
    if (timeout != null) {
      Timer(
        timeout,
        () {
          if (!event.completer.isCompleted) {
            event.completer.complete(
                AsyncEventResult<R>(status: AsyncEventResultStatus.timeout));
          }
        },
      );
    }

    /// Try assigning the completer's value to `result`
    /// If there is an error, then set the result status to error
    /// and forward the error object
    try {
      result = await event.completer.future;
    } catch (e) {
      result = AsyncEventResult<R>(
        status: AsyncEventResultStatus.error,
        error: e,
      );
    }

    return await _handleAsyncEventResult<R>(
      result: result,
      onError: onError,
      onTimeout: onTimeout,
    );
  }

  Future<R> _handleAsyncEventResult<R>({
    @required AsyncEventResult<R> result,
    @required AsyncValueSetter<Object> onError,
    @required AsyncCallback onTimeout,
  }) async {
    R _result;

    /// If there is no result, assume there was an error, and call the onError callback
    if (result == null) {
      await onError(null);
    } else {
      switch (result.status) {
        case AsyncEventResultStatus.ok:
          {
            _result = result.result;
          }
          break;
        case AsyncEventResultStatus.error:
          {
            if (onError != null) {
              await onError(result.error);
            }
          }
          break;
        case AsyncEventResultStatus.timeout:
          {
            if (onTimeout != null) {
              await onTimeout();
            }
          }
          break;
      }
    }
    return _result;
  }
}
