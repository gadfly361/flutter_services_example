import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fse/pages/posts/detail/scaffold.dart';
import 'package:fse/services/scaffold/events/show_snack_bar.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:fse/framework/services.dart';
import 'package:fse/services/db/app_db.dart';
import 'package:fse/services/db/models/posts/events/set_post.dart';
import 'package:fse/services/db/models/posts/supporting_models/comment.dart';
import 'package:fse/services/db/models/posts/supporting_models/post.dart';
import 'package:fse/services/http/events/get.dart';
import 'body.dart';

class PostsDetailPage_BodyWrapper extends StatefulWidget {
  final int index;

  PostsDetailPage_BodyWrapper({
    @required this.index,
  });

  @override
  PostsDetailPage_BodyWrapperState createState() =>
      PostsDetailPage_BodyWrapperState();
}

class PostsDetailPage_BodyWrapperState
    extends State<PostsDetailPage_BodyWrapper> {
  @override
  Widget build(BuildContext context) {
    return PostsDetailPage_Body(
      index: widget.index,
    );
  }

  @override
  void initState() {
    super.initState();

    /// We prefer to use [RouteAware]'s didPush, didPop, etc. whenever possible.
    /// However, when since we are using [OpenContainer] from the animations package,
    /// we aren't actually pushing a new route when we open this page, which means
    /// we can use RouteAware. So instead, we will settle for doing an http request here,
    /// in initState after the initial frame.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getComments();
    });
  }

  @override
  void dispose() {
    clearPost();
    super.dispose();
  }

  Future<void> getComments() async {
    final Services services = GetIt.I<Services>();
    final AppDb appDb = GetIt.I<AppDb>();
    final Post activePost = appDb.postsState.post;

    http.Response result = await services.dispatchAsyncEvent<http.Response>(
        event: Get_Http_Event(
          url:
              'https://jsonplaceholder.typicode.com/posts/${activePost.id}/comments',
        ),
        timeout: Duration(seconds: 5),
        onTimeout: () async {
          await services.dispatchAsyncEvent(
            event: ShowSnackBar_Scaffold_Event(
              scaffoldKey: PostsDetailPage_Scaffold.scaffoldKey,
              snackBar: SnackBar(
                backgroundColor: Colors.orange,
                content: Text('Your request has timed out!'),
              ),
            ),
          );
        },
        onError: (Object error) async {
          await services.dispatchAsyncEvent(
            event: ShowSnackBar_Scaffold_Event(
              scaffoldKey: PostsDetailPage_Scaffold.scaffoldKey,
              snackBar: SnackBar(
                backgroundColor: Colors.red,
                content:
                    Text('Uh oh, there was an error: \n\n${error.toString()}'),
              ),
            ),
          );
        });

    Iterable<dynamic> jsonList = jsonDecode(result.body);

    List<Comment> comments = List<Comment>.from(jsonList.map(
      (dynamic i) => Comment.fromJson(i),
    ));

    final Post updatedPost = activePost.copyWithComments(comments);

    await services.dispatchAsyncEvent(
        event: SetPost_Posts_Db_Event(post: updatedPost));
  }

  void clearPost() async {
    final Services services = GetIt.I<Services>();

    await services.dispatchAsyncEvent(
      event: SetPost_Posts_Db_Event(post: null),
    );
  }
}
