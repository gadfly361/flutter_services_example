import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:fse/framework/services.dart';
import 'package:fse/pages/example_of/http_error/scaffold.dart';
import 'package:fse/services/http/events/get.dart';
import 'package:http/http.dart' as http;
import 'package:fse/services/scaffold/events/show_snack_bar.dart';
import '../../../services/navigator/service.dart';
import 'body.dart';

class ExampleOfHttpErrorPage_BodyWrapper extends StatefulWidget {
  @override
  ExampleOfHttpErrorPage_BodyWrapperState createState() =>
      ExampleOfHttpErrorPage_BodyWrapperState();
}

class ExampleOfHttpErrorPage_BodyWrapperState
    extends State<ExampleOfHttpErrorPage_BodyWrapper> with RouteAware {
  @override
  Widget build(BuildContext context) {
    return ExampleOfHttpErrorPage_Body();
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

    await services.handleAsyncEventResult<http.Response>(
      result: await services.dispatchAsyncEvent(
        event: Get_Http_Event(
          url: 'this is a bad url and will throw an error',
        ),
      ),
      onOk: (http.Response response) async {
        print('this won\'t get executed because there is an error.');
      },
      onError: (Object error) async {
        await services.dispatchAsyncEvent(
          event: ShowSnackBar_Scaffold_Event(
            scaffoldKey: ExampleOfHttpErrorPage_Scaffold.scaffoldKey,
            snackBar: SnackBar(
              backgroundColor: Colors.red,
              content:
                  Text('Uh oh, there was an error: \n\n${error.toString()}'),
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
