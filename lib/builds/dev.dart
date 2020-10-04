import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:fse/app_root.dart';
import 'package:fse/builds/initial_events.dart';
import 'package:fse/builds/prep_build.dart';
import 'package:fse/environment_config.dart';
import 'package:fse/framework/async_event_result.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/services/db/app_db.dart';
import 'package:fse/services/db/models/posts/supporting_models/post.dart';
import 'package:fse/services/services_event_dispatcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prepBuild();

  _addDevServiceCallbacks();

  if (EnvironmentConfig.remoteDevTools) {
    await _connectRemoteDevTools();
  }

  await dispatchInitialEvents();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppRoot();
  }
}

void _addDevServiceCallbacks() {
  servicesEventDispatcher.addBeforeEventCallback((Event event) async {
    debugPrint('\n----------\nBEFORE ${event.toString()}');
  });

  servicesEventDispatcher.addAfterEventCallback(
      (Event event, AsyncEventResult<dynamic> result) async {
    if (EnvironmentConfig.logHttpBody && result.result is http.Response) {
      debugPrint((result.result as http.Response)?.body?.toString());
    } else if (result.result is List<Post>) {
      // no-op
    } else if (result.result != null) {
      debugPrint(result.result.toString());
    } else if (result.status == AsyncEventResultStatus.error) {
      debugPrint('\nERROR:\n${result?.error.toString()}\n');
    } else if (result.status == AsyncEventResultStatus.timeout) {
      debugPrint('\nTIMEOUT\n');
    }

    debugPrint(
        'AFTER  ${event.toString()}\n${String.fromCharCode(0x221F)}status: ${result?.status?.toString()?.split('.')?.last}');
  });
}

Future<DevToolsStore<AppDb>> _connectRemoteDevTools() async {
  debugPrint('connecting remote dev tools');

  final RemoteDevToolsMiddleware<AppDb> remoteDevtools =
      RemoteDevToolsMiddleware<AppDb>('localhost:8000');

  await remoteDevtools.connect();

  /// Remote dev tools is listening for dispatch events from a redux store.
  /// However, we are not using redux at all. So to 'fake it', we are creating a store
  /// and then dispatching events from it so remote dev tools picks it up. The store
  /// is not used for anything else.

  final DevToolsStore<AppDb> store = DevToolsStore<AppDb>(
      (AppDb _, dynamic action) => GetIt.I<AppDb>(),
      initialState: AppDb.initialState(),
      middleware: <Middleware>[remoteDevtools]);

  remoteDevtools.store = store;

  servicesEventDispatcher.addAfterEventCallback(
    (Event event, dynamic result) => store.dispatch(event.toString()),
  );
  return store;
}
