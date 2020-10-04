import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:fse/framework/services.dart';
import 'package:fse/services/db/app_db.dart';
import 'package:fse/services/db/models/navigation/events/set_bottom_navigation_bar_index.dart';
import 'package:fse/services/navigator/events/push_named_and_replace_all.dart';
import 'package:fse/services/navigator/service.dart';

class SharedBottomNavigationBar_Connector extends StatelessWidget {
  AppRoute getAppRouteFromIndex(int index) {
    AppRoute appRoute;

    switch (index) {
      case 0:
        {
          appRoute = AppRoute.postsOverviewPage;
        }
        break;
      case 1:
        {
          appRoute = AppRoute.exampleOfHttpError;
        }
        break;
      case 2:
        {
          appRoute = AppRoute.exampleOfHttpTimeout;
        }
        break;
    }

    return appRoute;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AppDb, int>(
      selector: (BuildContext context, AppDb appDb) {
        return appDb.navigationState.bottomNavigationBarIndex;
      },
      builder: (BuildContext context, int bottomNavigationBarIndex, _) {
        return BottomNavigationBar(
          onTap: (int index) async {
            final Services services = GetIt.I<Services>();
            await services.dispatchAsyncEvent(
              event:
                  SetBottomNavigationBarIndex_Navigation_Db_Event(index: index),
            );

            await services.dispatchAsyncEvent(
              event: PushNamedAndReplaceAll_Navigator_Event(
                appRoute: getAppRouteFromIndex(index),
              ),
            );
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          currentIndex: bottomNavigationBarIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline),
              title: Text('Posts'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.error_outline),
              title: Text('Error'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer_off),
              title: Text('Timeout'),
            ),
          ],
        );
      },
    );
  }
}
