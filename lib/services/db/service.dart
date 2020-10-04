import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import 'app_db.dart';

class DbService {
  StreamController<AppDb> _dbStream;

  Stream<AppDb> getStateStream() {
    return _dbStream.stream;
  }

  void updateDbStream(AppDb db) {
    _dbStream.add(db);
  }

  void startDbStream() {
    debugPrint('starting db stream');
    _dbStream = StreamController<AppDb>.broadcast(
      sync: true,
    );

    _dbStream.stream.listen((AppDb db) {
      GetIt.I.unregister<AppDb>();
      GetIt.I.registerSingleton<AppDb>(db);
    });
  }

  Future<void> closeDbStream() async {
    if (!(_dbStream?.isClosed ?? true)) {
      debugPrint('closing db stream');
      await _dbStream.close();
    }
  }

  void initService() {
    GetIt.I.registerSingleton<AppDb>(AppDb.initialState());

    GetIt.I<DbService>().startDbStream();
  }
}
