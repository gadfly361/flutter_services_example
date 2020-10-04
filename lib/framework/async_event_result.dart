import 'package:meta/meta.dart';

enum AsyncEventResultStatus {
  ok,
  error,
  timeout,
}

class AsyncEventResult<R> {
  final R result;
  final AsyncEventResultStatus status;
  final Object error;

  AsyncEventResult({
    @required this.status,
    this.result,
    this.error,
  });
}
