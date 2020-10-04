import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fse/pages/posts/detail/widgets_dumb/comments.dart';
import 'package:fse/services/db/app_db.dart';
import 'package:fse/services/db/models/posts/supporting_models/comment.dart';

class Comments_Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<AppDb, List<Comment>>(
      selector: (BuildContext context, AppDb appDb) {
        return appDb.postsState?.post?.comments;
      },
      builder: (BuildContext context, List<Comment> comments, _) {
        return Comments_Dumb(comments: comments);
      },
    );
  }
}
