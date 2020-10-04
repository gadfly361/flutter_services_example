import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';
import 'package:fse/framework/event.dart';
import 'package:fse/framework/event_processor.dart';
import 'package:fse/services/db/app_db.dart';
import 'package:fse/services/db/models/navigation/model_event_dispatcher.dart';
import 'package:fse/services/db/service.dart';

class SetBottomNavigationBarIndex_Navigation_Db_Event
    extends Navigation_Db_Event {
  final int index;

  SetBottomNavigationBarIndex_Navigation_Db_Event({
    @required this.index,
  }) : super(eventType: Navigation_Db_EventType.setBottomNavigationBarIndex);
}

EventHandler<int> setBottomNavigationBarIndex_Navigation_Db_EventHandler =
    EventHandler<int>(
  handler: (Event _event) async {
    SetBottomNavigationBarIndex_Navigation_Db_Event event =
        _event as SetBottomNavigationBarIndex_Navigation_Db_Event;

    AppDb appDbOld = GetIt.I<AppDb>();

    AppDb appDbNew = appDbOld.copyWith(
      navigationState: appDbOld.navigationState.copyWith(
        bottomNavigationBarIndex: event.index,
      ),
    );

    GetIt.I<DbService>().updateDbStream(appDbNew);

    return event.index;
  },
);
