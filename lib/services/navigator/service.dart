import 'package:flutter/material.dart';
import 'package:fse/pages/example_of/http_error/scaffold.dart';
import 'package:fse/pages/example_of/http_timeout/scaffold.dart';
import 'package:fse/pages/posts/overview/scaffold.dart';
import 'package:fse/services/navigator/route_transitions/no_visible_transition.dart';

enum AppRoute {
  postsOverviewPage,
  exampleOfHttpError,
  exampleOfHttpTimeout,
}

class NavigatorService {
  final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();
  final RouteObserver<PageRoute<dynamic>> appRouteObserver =
      RouteObserver<PageRoute<dynamic>>();

  final String initialRoute = AppRoute.postsOverviewPage.toString();

  Route<dynamic> appOnGenerateRoute(RouteSettings settings) {
    Route<dynamic> _route;
    AppRoute routeName = AppRoute.values.firstWhere(
        (AppRoute appRoute) => appRoute.toString() == settings.name);

    switch (routeName) {
      case AppRoute.postsOverviewPage:
        {
          _route = NoVisibleTransitionRoute(
            settings: settings,
            widget: PostsOverviewPage_Scaffold(),
            canUseBackButton: false,
          );
        }
        break;
      case AppRoute.exampleOfHttpError:
        {
          _route = NoVisibleTransitionRoute(
            settings: settings,
            widget: ExampleOfHttpErrorPage_Scaffold(),
            canUseBackButton: false,
          );
        }
        break;
      case AppRoute.exampleOfHttpTimeout:
        {
          _route = NoVisibleTransitionRoute(
            settings: settings,
            widget: ExampleOfHttpTimeoutPage_Scaffold(),
            canUseBackButton: false,
          );
        }
        break;
    }

    return _route;
  }
}
