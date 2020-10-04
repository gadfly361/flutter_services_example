import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../services/navigator/service.dart';
import 'body.dart';

class TemplatePage_BodyWrapper extends StatefulWidget {
  @override
  TemplatePage_BodyWrapperState createState() =>
      TemplatePage_BodyWrapperState();
}

class TemplatePage_BodyWrapperState extends State<TemplatePage_BodyWrapper>
    with RouteAware {
  @override
  Widget build(BuildContext context) {
    return TemplatePage_Body();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GetIt.I<NavigatorService>()
        .appRouteObserver
        .subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    GetIt.I<NavigatorService>().appRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() async {}

  @override
  void didPop() async {}

  @override
  void didPopNext() async {}

  @override
  void didPushNext() async {}
}
