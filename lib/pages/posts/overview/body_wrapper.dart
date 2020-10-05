import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fse/pages/posts/overview/scaffold.dart';
import 'package:fse/services/http/service.dart';
import 'package:fse/services/scaffold/events/show_snack_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:fse/framework/services.dart';
import 'package:fse/pages/posts/overview/body.dart';
import 'package:fse/services/db/models/posts/events/set_posts.dart';
import 'package:fse/services/db/models/posts/supporting_models/post.dart';
import 'package:fse/services/http/events/get.dart';
import 'package:fse/services/navigator/service.dart';

class PostsOverviewPage_BodyWrapper extends StatefulWidget {
  @override
  PostsOverviewPage_BodyWrapperState createState() =>
      PostsOverviewPage_BodyWrapperState();
}

class PostsOverviewPage_BodyWrapperState
    extends State<PostsOverviewPage_BodyWrapper> with RouteAware {
  @override
  Widget build(BuildContext context) {
    return PostsOverviewPage_Body();
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

  Future<void> getPosts() async {
    Services services = GetIt.I<Services>();

    http.Response result = await services.dispatchAsyncEvent<http.Response>(
        event: Get_Http_Event(
          url: HttpService.jsonPlaceholderPostsUrl,
        ),
        timeout: Duration(seconds: 5),
        onTimeout: () async {
          await services.dispatchAsyncEvent(
            event: ShowSnackBar_Scaffold_Event(
              scaffoldKey: PostsOverviewPage_Scaffold.scaffoldKey,
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
              scaffoldKey: PostsOverviewPage_Scaffold.scaffoldKey,
              snackBar: SnackBar(
                backgroundColor: Colors.red,
                content:
                    Text('Uh oh, there was an error: \n\n${error.toString()}'),
              ),
            ),
          );
        });

    List<Post> postsFullList = (json.decode(result?.body) as List<dynamic>)
        ?.map((dynamic i) => Post.fromJson(i))
        ?.toList();

    // Since this is a demo application, and we don't have real credentials,
    // let's assume we are the user with userId 1, and filter the posts that
    // belong to us.
    List<Post> postsTruncatedList =
        postsFullList?.where((Post post) => post.userId == 1)?.toList();

    await services.dispatchAsyncEvent(
        event: SetPosts_Posts_Db_Event(posts: postsTruncatedList));
  }

  @override
  void didPush() async {
    await getPosts();
  }

  @override
  void didPop() async {}

  @override
  void didPopNext() async {}

  @override
  void didPushNext() async {}
}
