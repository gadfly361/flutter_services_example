import 'package:get_it/get_it.dart';
import 'package:fse/framework/services.dart';
import 'package:fse/services/db/models/posts/events/set_favorite_post_ids_from_string_list.dart';
import 'package:fse/services/db/models/posts/model.dart';
import 'package:fse/services/shared_preferences/events/get_string_list.dart';

Future<void> dispatchInitialEvents() async {
  final Services services = GetIt.I<Services>();

  await services.handleAsyncEventResult<List<String>>(
    result: await services.dispatchAsyncEvent(
      event: GetStringList_SharedPreferences_Event(
          key: PostsState.favoritePostsById_SharedPreferencesKey),
    ),
    onOk: (List<String> stringList) async {
      await services.dispatchAsyncEvent(
          event: SetFavoritePostIdsFromStringList_Posts_Db_Event(
              stringList: stringList));
    },
  );
}
