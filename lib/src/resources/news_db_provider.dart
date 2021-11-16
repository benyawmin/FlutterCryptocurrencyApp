// import 'dart:io';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';

// class NewsDbProvider {
//   late Database db;

//   NewsDbProvider() {
//     init();
//   }

//   void init() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     final path = join(documentsDirectory.path, 'dbase1.db');
//     db = await openDatabase(path, version: 1,
//         onCreate: (Database newDb, int version) {
//       newDb.execute("""
//           CREATE TABLE NewsItems
//           (
//                 id TEXT PRIMARY KEY,
//                 title TEXT,
//                 description TEXT,
//                 url TEXT,
//                 author TEXT,
//                 image TEXT,
//                 language TEXT,
//                 category BLOB,
//                 published TEXT
//           )
//           """);
//     });
//   }

//   // fetchItem(int id) async {
//   //   final maps = await db.query(
//   //     "NewsItems",
//   //     columns: null,
//   //     where: "id = ?",
//   //     whereArgs: [id],
//   //   );

//   //   if (maps.length > 0) {
//   //     return NewsModel.fromDb(maps.first);
//   //   }

//   //   return null;
//   // }

//   fetchAllItems() async {
//     final maps = await db.query(
//       "NewsItems",
//       columns: null,
//       where: null,
//     );

//     if (maps.length > 0) {
//       // print(News.fromDb(maps.first).category);
//       // print(maps[1]);
//       print(NewsModel.fromDb(maps).dbNews);
//       return NewsModel.fromDb(maps).dbNews;
//     }

//     return null;
//   }

//   addItem(item) {
//     return db.insert(
//       "NewsItems",
//       item.toJson(),
//       conflictAlgorithm: ConflictAlgorithm.ignore,
//     );
//   }

//   deleteItem(id) async {
//     return await db.delete('NewsItems', where: 'id = ?', whereArgs: [id]);
//   }

//   clear() {
//     return db.delete('NewsItems');
//   }
// }

// final newsDbProvider = NewsDbProvider();
