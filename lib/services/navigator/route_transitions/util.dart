import 'package:flutter/material.dart';

class CanUseBackButtonResolver extends StatelessWidget {
  final bool canUseBackButton;
  final Widget child;

  CanUseBackButtonResolver({
    @required this.canUseBackButton,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return canUseBackButton
        ? child
        : WillPopScope(
            onWillPop: () async => false,
            child: child,
          );
  }
}
