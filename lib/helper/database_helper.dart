import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String tableChairs = "Chairs";

  static Future createDatabase() async {
    final databasePath = await getDatabasesPath();
    return openDatabase(
      join(databasePath, "Chair.db"),
      version: 2,
      onCreate: (database, version) {
        return database.execute('''CREATE TABLE Chairs (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            imagePath TEXT,
             title TEXT ,
             description TEXT , 
             dateTime TEXT
             status TEXT)''');
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getDataFromDatabase() async {
    final database = await DatabaseHelper.createDatabase();
    return await database.query("Chairs", orderBy: "dateTime ASC");
  }

  static Future insert(Map<String, Object> data) async {
    final database = await DatabaseHelper.createDatabase();
    database.insert("Chairs", data , conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
