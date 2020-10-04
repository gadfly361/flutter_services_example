import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fse/services/db/app_db.dart';
import 'package:fse/services/db/models/posts/supporting_models/post.dart';

class Title_Text_Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<AppDb, Post>(
      selector: (BuildContext context, AppDb appDb) {
        return appDb.postsState.post;
      },
      builder: (BuildContext context, Post post, _) {
        return Text('Post ${post?.id}');
      },
    );
  }
}
