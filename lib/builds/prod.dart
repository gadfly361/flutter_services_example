import 'package:flutter/material.dart';
import 'package:fse/app_root.dart';
import 'package:fse/builds/initial_events.dart';
import 'package:fse/builds/prep_build.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prepBuild();

  await dispatchInitialEvents();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppRoot();
  }
}
