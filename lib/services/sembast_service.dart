// import 'package:sembast/sembast.dart';
// import 'package:sembast/sembast_io.dart';

// class SembastService {
//   final Database _database;

//   SembastService(this._database);

//   Future<Database> getDatabase() async => _database;
// Future<void> storeDaypCountData(Map<String, dynamic> data) async {
//     final store = intMapStoreFactory.store('dayp_count_data');
//     await store.add(_database, data);
//   }

//   Future<Map<String, dynamic>?> getDaypCountData() async {
//     final store = intMapStoreFactory.store('dayp_count_data');
//     final record = await store.findFirst(_database);
//     return record?.value;
//   }
//   // Add methods for CRUD operations (create, read, update, delete)
//   // based on your data model and needs.
// }
