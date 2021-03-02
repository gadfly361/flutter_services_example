import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'async_event_result.dart';
import 'event.dart';

/// Typedefs

typedef BeforeEventCallback = Future<void> Function(Event event);

typedef AfterEventCallback<R> = Future<void> Function(
  Event event,
  AsyncEventResult<R> result,
);

typedef EventHandlerCallback<R> = Future<R> Function(Event event);

/// [EventProcessor] is an abstract class that allows for
/// the addition of before and after event processing callbacks.
/// Concrete implementations of [EventProcessor]s include:
///
/// 1) [EventDispatcher] is used to pipe an event forward
/// and still gives the opportunity to add before and after callbacks at that level.
/// EventDispatcher's can be chained N times.
///
/// 2) [EventHandler] is used as the final step in the chain. The thing that
/// actually does something! Note, there is still an opportunity to add before and after
/// callbacks at this level too.

class EventDispatcher extends EventProcessor {
  final AsyncValueSetter<Event> _dispatcher;

  EventDispatcher({
    @required AsyncValueSetter<Event> dispatcher,
  }) : _dispatcher = dispatcher;

  @override
  Future<void> _processor(Event event) {
    return _dispatcher(event);
  }
}

class EventHandler<R> extends EventProcessor {
  final EventHandlerCallback<R> _handler;

  EventHandler({
    @required EventHandlerCallback<R> handler,
  }) : _handler = handler;

  @override
  Future<void> _processor(Event event) async {
    try {
      R result = await _handler(event);

      if (!event.completer.isCompleted) {
        event.completer.complete(
          AsyncEventResult<R>(
            status: AsyncEventResultStatus.ok,
            result: result,
          ),
        );
      }
    } catch (e) {
      if (!event.completer.isCompleted) {
        event.completer.complete(
          AsyncEventResult<R>(
            status: AsyncEventResultStatus.error,
            error: e,
          ),
        );
      }
    }
  }
}

abstract class EventProcessor {
  final List<BeforeEventCallback> _beforeEventCallbacks =
      <BeforeEventCallback>[];
  final List<AfterEventCallback> _afterEventCallbacks = <AfterEventCallback>[];

  void addBeforeEventCallback(BeforeEventCallback b) =>
      _beforeEventCallbacks.add(b);

  void addAfterEventCallback(AfterEventCallback a) =>
      _afterEventCallbacks.add(a);

  // Needs to be overwritten
  Future<void> _processor(Event event) async {
    return null;
  }

  Future<void> processEvent({
    @required Event event,
  }) async {
    // 1) run before callbacks in order
    await _beforeEventCallbacks?.forEach((BeforeEventCallback b) async {
      await b(event);
    });

    // 2) process the event and await for its result
    await _processor(event);
    Completer<dynamic> completer = event.completer;
    dynamic result = await completer.future;

    // 3) run after callbacks in order
    await _afterEventCallbacks?.forEach((AfterEventCallback f) async {
      await f(event, result);
    });
  }
}
