import 'package:flutter/material.dart';
import 'util.dart';

class NoVisibleTransitionRoute extends PageRouteBuilder<dynamic> {
  final Widget widget;
  @override
  final RouteSettings settings;
  final bool canUseBackButton;

  NoVisibleTransitionRoute({
    @required this.settings,
    @required this.widget,
    @required this.canUseBackButton,
  }) : super(
          settings: settings,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return CanUseBackButtonResolver(
              child: widget,
              canUseBackButton: canUseBackButton,
            );
          },
        );
}
