import 'package:flutter/material.dart';
import 'package:fse/pages/posts/overview/widgets_connector/posts_list.dart';
import 'package:fse/shared/widgets_dumb/fade_in_slide_up.dart';

class PostsOverviewPage_Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SharedFadeInSlideUp_Dumb(
      child: Posts_List_Connector(),
    );
  }
}
