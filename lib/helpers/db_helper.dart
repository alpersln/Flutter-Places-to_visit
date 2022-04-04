import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await sql.getDatabasesPath();
    String path = join(dbPath, 'places.db');
    final sqlDb = await sql.openDatabase(path, onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT, image TEXT)");
    }, version: 1);
    sqlDb.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
}
