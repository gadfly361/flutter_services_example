import 'package:flutter/material.dart';
import 'package:fse/pages/posts/detail/widgets_connector/comments.dart';
import 'package:fse/pages/posts/detail/widgets_connector/post_summary.dart';
import 'package:fse/shared/styles/spacings.dart';

class PostsDetailPage_Body extends StatelessWidget {
  final int index;

  PostsDetailPage_Body({
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PostSummary_Connector(index: index),
        SizedBox(height: Spacings.m),
        Expanded(
          child: Comments_Connector(),
        ),
      ],
    );
  }
}
