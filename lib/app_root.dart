import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:fse/services/db/service.dart';
import 'package:fse/services/navigator/service.dart';
import 'package:fse/shared/styles/text_theme.dart';
import 'services/db/app_db.dart';

class AppRoot extends StatelessWidget {
  final RouteFactory onGenerateRoute;

  AppRoot({
    this.onGenerateRoute,
  });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppDb>(
      initialData: GetIt.I<AppDb>(),
      create: (_) => GetIt.I<DbService>().getStateStream(),
      catchError: null,
      updateShouldNotify: (AppDb previous, AppDb current) => true,
      child: MaterialAppRoot(
        onGenerateRoute:
            onGenerateRoute ?? GetIt.I<NavigatorService>().appOnGenerateRoute,
      ),
    );
  }
}

class MaterialAppRoot extends StatefulWidget {
  final RouteFactory onGenerateRoute;

  MaterialAppRoot({
    @required this.onGenerateRoute,
  });

  @override
  _MaterialAppRootState createState() => _MaterialAppRootState();
}

class _MaterialAppRootState extends State<MaterialAppRoot>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GetIt.I<NavigatorService>().appNavigatorKey,
      navigatorObservers: <NavigatorObserver>[
        GetIt.I<NavigatorService>().appRouteObserver
      ],
      initialRoute: GetIt.I<NavigatorService>().initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        textTheme: appTextTheme(context),
      ),
    );
  }
}
