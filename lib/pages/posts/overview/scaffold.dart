import 'package:flutter/material.dart';
import 'package:fse/pages/posts/overview/body_wrapper.dart';
import 'package:fse/shared/widgets_connector/bottom_navigation_bar.dart';

class PostsOverviewPage_Scaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: PostsOverviewPage_BodyWrapper(),
      bottomNavigationBar: SharedBottomNavigationBar_Connector(),
    );
  }
}
