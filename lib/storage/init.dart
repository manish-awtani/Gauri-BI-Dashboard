// import 'package:flutter_application_1/services/sembast_service.dart';
// import 'package:get_it/get_it.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'package:sembast/sembast.dart';
// import 'package:sembast/sembast_io.dart';

// class Init {
//   static Future initialize() async {
//     final database = await _initSembast();
//     GetIt.I.registerSingleton<SembastService>(SembastService(database));
//   }

//   static Future _initSembast() async {
//     final appDir = await getApplicationDocumentsDirectory();
//     await appDir.create(recursive: true);
//     final databasePath = join(appDir.path, "sembast.db");
//     final database = await databaseFactoryIo.openDatabase(databasePath);
//     return database;
//   }
// }
