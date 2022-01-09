import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/chair.dart';

class DatabaseHelper {
  static Future createDatabase() async {
    try {
      final databasePath = await getDatabasesPath();
      return openDatabase(
        join(databasePath, 'Chair.db'),
        version: 2,
        onCreate: (database, version) {
          return database.execute('''CREATE TABLE chairs (
                  id INTEGER PRIMARY KEY AUTOINCREMENT, 
                  imagePath TEXT,
                   title TEXT ,
                   description TEXT , 
                    status TEXT )''');
        },
      );
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> getDataFromDatabase() async {
    final database = await DatabaseHelper.createDatabase();
    return await database.query("chairs", orderBy: "id DESC");
  }

  static Future insert(Chair chair) async {
    final database = await DatabaseHelper.createDatabase();
    database.insert("chairs", chair.toJson());
  }

  static Future update(Chair chair) async {
    final database = await DatabaseHelper.createDatabase();
    return database.update(
      'chairs',
      chair.toJson(),
      where: 'id = ?',
      whereArgs: [chair.id],
    );
  }

  static Future delete(int id) async {
    final database = await DatabaseHelper.createDatabase();
    return database.delete("chairs", where: 'id =?', whereArgs: [id]);
  }
}
