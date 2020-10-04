import 'package:flutter/material.dart';
import 'package:fse/pages/posts/detail/widgets_connector/title_text.dart';
import 'body_wrapper.dart';

class PostsDetailPage_Scaffold extends StatelessWidget {
  final int index;

  PostsDetailPage_Scaffold({
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Title_Text_Connector(),
            backgroundColor: Colors.purple,
          ),
          body: PostsDetailPage_BodyWrapper(
            index: index,
          ),
        ),
      ),
    );
  }
}
