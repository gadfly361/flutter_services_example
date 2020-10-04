import 'package:flutter/material.dart';
import 'package:fse/shared/widgets_connector/bottom_navigation_bar.dart';
import 'body_wrapper.dart';

class ExampleOfHttpErrorPage_Scaffold extends StatelessWidget {
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Example of an http error'),
      ),
      body: ExampleOfHttpErrorPage_BodyWrapper(),
      bottomNavigationBar: SharedBottomNavigationBar_Connector(),
    );
  }
}
