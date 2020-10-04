import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:fse/framework/services.dart';
import 'package:fse/pages/example_of/http_timeout/scaffold.dart';
import 'package:fse/services/http/events/get.dart';
import 'package:fse/services/scaffold/events/show_snack_bar.dart';
import '../../../services/navigator/service.dart';
import 'body.dart';

class ExampleOfHttpTimeoutPage_BodyWrapper extends StatefulWidget {
  @override
  ExampleOfHttpTimeoutPage_BodyWrapperState createState() =>
      ExampleOfHttpTimeoutPage_BodyWrapperState();
}

class ExampleOfHttpTimeoutPage_BodyWrapperState
    extends State<ExampleOfHttpTimeoutPage_BodyWrapper> with RouteAware {
  @override
  Widget build(BuildContext context) {
    return ExampleOfHttpTimeoutPage_Body();
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
  void didPush() async {
    final Services services = GetIt.I<Services>();

    await services.dispatchAsyncEvent<http.Response>(
      event: Get_Http_Event(url: 'http://google.com'),
      timeout: Duration(milliseconds: 0),
      onTimeout: () async {
        await services.dispatchAsyncEvent(
          event: ShowSnackBar_Scaffold_Event(
            scaffoldKey: ExampleOfHttpTimeoutPage_Scaffold.scaffoldKey,
            snackBar: SnackBar(
              backgroundColor: Colors.orange,
              content: Text(
                'Your http request has timed out!',
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void didPop() async {}

  @override
  void didPopNext() async {}

  @override
  void didPushNext() async {}
}
