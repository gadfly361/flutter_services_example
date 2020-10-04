import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:fse/framework/services.dart';
import 'package:fse/pages/posts/detail/scaffold.dart';
import 'package:fse/pages/posts/overview/body_wrapper.dart';
import 'package:fse/pages/posts/overview/widgets_dumb/post_card.dart';
import 'package:fse/services/db/app_db.dart';
import 'package:fse/services/db/models/posts/events/set_post.dart';
import 'package:fse/services/db/models/posts/events/toggle_favorite_post_by_id.dart';
import 'package:fse/services/db/models/posts/model.dart';
import 'package:fse/services/db/models/posts/supporting_models/post.dart';
import 'package:fse/services/pull_to_refresh/service_event_handler.dart';
import 'package:fse/services/shared_preferences/events/set_string_list.dart';
import 'package:fse/shared/styles/spacings.dart';

class Posts_List_Connector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<AppDb, PostsState>(
      selector: (BuildContext context, AppDb appDb) {
        return appDb.postsState;
      },
      builder: (BuildContext context, PostsState postsState, _) {
        return LiquidPullToRefresh(
          color: Colors.purple,
          backgroundColor: Colors.purpleAccent,
          springAnimationDurationInMilliseconds: 500,
          onRefresh: () async {
            final Services services = GetIt.I<Services>();
            final PostsOverviewPage_BodyWrapperState bodyWrapperState = context
                .findAncestorStateOfType<PostsOverviewPage_BodyWrapperState>();
            await services.dispatchAsyncEvent(
              event: PullToRefresh_Event(onRefresh: () async {
                await bodyWrapperState.getPosts();
              }),
            );
          },
          child: Container(
            color: Colors.grey[300],
            child: ListView.separated(
              padding: EdgeInsets.all(Spacings.l),
              itemBuilder: (BuildContext context, int index) {
                final Post post = postsState.posts[index];

                return OpenContainer(
                  tappable: false,
                  transitionDuration: Duration(milliseconds: 500),
                  openBuilder:
                      (BuildContext context, VoidCallback closeContainer) {
                    return PostsDetailPage_Scaffold(index: index);
                  },
                  closedElevation: 0,
                  closedBuilder:
                      (BuildContext context, VoidCallback openContainer) {
                    return Post_Card_Dumb(
                      post: post,
                      index: index,
                      isFavorite:
                          postsState?.favoritePostsById?.contains(post.id) ??
                              false,
                      onFavoriteTapAsync: () async {
                        Services services = GetIt.I<Services>();
                        await services.handleAsyncEventResult<Set<int>>(
                          result: await services.dispatchAsyncEvent(
                            event: ToggleFavoritePostById_Posts_Db_Event(
                                postId: post.id),
                          ),
                          onOk: (Set<int> favoritePostsById) async {
                            List<String> _stringList = favoritePostsById
                                .map((int id) => id.toString())
                                .toList();

                            await services.dispatchAsyncEvent(
                              event: SetStringList_SharedPreferences_Event(
                                key: PostsState
                                    .favoritePostsById_SharedPreferencesKey,
                                stringList: _stringList,
                              ),
                            );
                          },
                        );
                      },
                      onCardTapAsync: () async {
                        await GetIt.I<Services>().dispatchAsyncEvent(
                          event: SetPost_Posts_Db_Event(post: post),
                        );

                        openContainer();
                      },
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: Spacings.l);
              },
              itemCount: postsState?.posts?.length ?? 0,
            ),
          ),
        );
      },
    );
  }
}
