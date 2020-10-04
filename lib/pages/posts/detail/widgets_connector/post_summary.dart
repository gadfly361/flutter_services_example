import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fse/pages/posts/detail/widgets_dumb/post_summary.dart';
import 'package:fse/services/db/app_db.dart';
import 'package:fse/services/db/models/posts/supporting_models/post.dart';

class PostSummary_Connector extends StatelessWidget {
  final int index;

  PostSummary_Connector({
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<AppDb, Post>(
      selector: (BuildContext context, AppDb appDb) {
        return appDb.postsState.post;
      },
      builder: (BuildContext context, Post post, _) {
        return PostSummary_Dumb(
          post: post,
          index: index,
        );
      },
    );
  }
}
