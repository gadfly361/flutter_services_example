import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fse/app_root.dart';
import 'package:fse/builds/initial_events.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/pages/posts/detail/scaffold.dart';
import 'package:fse/pages/posts/overview/scaffold.dart';
import 'package:fse/pages/posts/overview/widgets_dumb/post_card.dart';
import 'package:fse/services/db/models/posts/events/set_favorite_post_ids_from_string_list.dart';
import 'package:fse/services/db/models/posts/events/set_post.dart';
import 'package:fse/services/db/models/posts/events/set_posts.dart';
import 'package:fse/services/http/events/get.dart';
import 'package:fse/services/http/service.dart';
import 'package:fse/services/scaffold/events/show_snack_bar.dart';
import 'package:fse/services/shared_preferences/events/get_string_list.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import '../../../app_fixture.dart';
import '../../../services_util.dart';
import 'mocks.dart';

void main() {
  setUp(AppFixture.setUp);
  tearDown(AppFixture.tearDown);

  testWidgets(
    '[Posts Overview -> Posts Detail] Success',
    (WidgetTester tester) async {
      await tester.runAsync(
        () async {
          List<Event> serviceEventsRecorded = startRecordingServiceEvents();
          await dispatchInitialEvents();

          /// App starts up and lands on [PostsOverviewPage_Scaffold]
          /// which makes an http request to json placeholder api
          /// that we need to mock
          when(
            GetIt.I<HttpService>().httpClient.get(
                  HttpService.jsonPlaceholderPostsUrl,
                  headers: anyNamed('headers'),
                ),
          ).thenAnswer((_) async {
            return http.Response(jsonEncode(postsSuccessResponse), 200,
                headers: defaultJsonHeaders);
          });

          await tester.pumpWidget(AppRoot());
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          /// Upon launch, shared_preferences is checked to see if there are any favorited posts,
          /// sets them in our AppDb,
          /// makes an http request to json placeholder api to get posts,
          /// and then sets the posts in our AppDb
          areServiceEventsInExpectedOrder(
            serviceEventsExpected: <Type>[
              GetStringList_SharedPreferences_Event,
              SetFavoritePostIdsFromStringList_Posts_Db_Event,
              Get_Http_Event,
              SetPosts_Posts_Db_Event,
            ],
            serviceEventsRecorded: serviceEventsRecorded,
          );

          /// Expect to be on the PortfolioOverviewPage
          expect(find.byType(PostsOverviewPage_Scaffold), findsOneWidget);

          /// With post cards, including a one with an id of 1
          int postId = 1;
          Finder postCardDumbFinder =
              find.byKey(Key('${Post_Card_Dumb.keyPrefix}_$postId'));
          expect(postCardDumbFinder, findsOneWidget);

          /// Tapping on [Post_Card_Dumb] will navigate us to the [PostsDetailPage_Scaffold]
          /// and will trigger an http request to json placeholder for the comments belonging to
          /// the post with id of 1
          when(
            GetIt.I<HttpService>().httpClient.get(
                  HttpService.jsonPlaceholderPostCommentsUrl(postId),
                  headers: anyNamed('headers'),
                ),
          ).thenAnswer((_) async {
            return http.Response(jsonEncode(postCommentsSuccessResponse), 200,
                headers: defaultJsonHeaders);
          });

          await tester.tap(postCardDumbFinder);
          await tester.pumpAndSettle();

          /// When we click on the card, we are setting the post to [PostsState],
          /// using the animation packages [OpenContainer] to go to the [PostsDetailPage_Scaffold],
          /// which will make an http request to json placeholder for that posts comments,
          /// and once we have the comments, we will set the comments in our AppDb
          areServiceEventsInExpectedOrder(
            serviceEventsExpected: <Type>[
              SetPost_Posts_Db_Event,
              Get_Http_Event,
              SetPost_Posts_Db_Event,
            ],
            serviceEventsRecorded: serviceEventsRecorded,
          );

          expect(find.byType(PostsDetailPage_Scaffold), findsOneWidget);
          expect(find.byType(PostsOverviewPage_Scaffold), findsNothing);
          expect(find.byType(PostsOverviewPage_Scaffold, skipOffstage: false),
              findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    '[Posts Overview -> Posts Detail] Zero posts',
    (WidgetTester tester) async {
      await tester.runAsync(
        () async {
          List<Event> serviceEventsRecorded = startRecordingServiceEvents();
          await dispatchInitialEvents();

          /// App starts up and lands on [PostsOverviewPage_Scaffold]
          /// which makes an http request to json placeholder api
          /// that we need to mock
          when(
            GetIt.I<HttpService>().httpClient.get(
                  HttpService.jsonPlaceholderPostsUrl,
                  headers: anyNamed('headers'),
                ),
          ).thenAnswer((_) async {
            return http.Response(jsonEncode(postsSuccessResponse_empty), 200,
                headers: defaultJsonHeaders);
          });

          await tester.pumpWidget(AppRoot());
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          /// Upon launch, shared_preferences is checked to see if there are any favorited posts,
          /// sets them in our AppDb,
          /// makes an http request to json placeholder api to get posts,
          /// and then sets the posts in our AppDb
          areServiceEventsInExpectedOrder(
            serviceEventsExpected: <Type>[
              GetStringList_SharedPreferences_Event,
              SetFavoritePostIdsFromStringList_Posts_Db_Event,
              Get_Http_Event,
              SetPosts_Posts_Db_Event,
            ],
            serviceEventsRecorded: serviceEventsRecorded,
          );

          /// Expect to be on the PortfolioOverviewPage
          /// with zero posts
          expect(find.byType(PostsOverviewPage_Scaffold), findsOneWidget);
          expect(find.byType(Post_Card_Dumb), findsNothing);
          expect(find.byType(SnackBar), findsNothing);
        },
      );
    },
  );

  testWidgets(
    '[Posts Overview -> Posts Detail] Error when fetching posts',
    (WidgetTester tester) async {
      await tester.runAsync(
        () async {
          List<Event> serviceEventsRecorded = startRecordingServiceEvents();
          await dispatchInitialEvents();

          /// App starts up and lands on [PostsOverviewPage_Scaffold]
          /// which makes an http request to json placeholder api
          /// that we need to mock
          when(
            GetIt.I<HttpService>().httpClient.get(
                  HttpService.jsonPlaceholderPostsUrl,
                  headers: anyNamed('headers'),
                ),
          ).thenAnswer((_) async {
            throw (Exception());
          });

          await tester.pumpWidget(AppRoot());
          await tester.pumpAndSettle();
          await tester.pumpAndSettle();

          /// Upon launch, shared_preferences is checked to see if there are any favorited posts,
          /// sets them in our AppDb,
          /// makes an http request to json placeholder api to get posts,
          /// and then sets the posts in our AppDb
          areServiceEventsInExpectedOrder(
            serviceEventsExpected: <Type>[
              GetStringList_SharedPreferences_Event,
              SetFavoritePostIdsFromStringList_Posts_Db_Event,
              Get_Http_Event,
              ShowSnackBar_Scaffold_Event,
            ],
            serviceEventsRecorded: serviceEventsRecorded,
          );

          /// Expect to be on the PortfolioOverviewPage
          /// with zero posts
          expect(find.byType(PostsOverviewPage_Scaffold), findsOneWidget);
          expect(find.byType(Post_Card_Dumb), findsNothing);
          expect(find.byType(SnackBar), findsOneWidget);
        },
      );
    },
  );
}
