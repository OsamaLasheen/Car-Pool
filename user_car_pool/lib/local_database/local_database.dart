import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseRepository {

  Database?_database;

  Future<Database?> get database async {
    //resetDatabase();
    if(_database != null) {
      return _database;
    }

    _database = await _initDB('db');
  return _database!;

  }

  Future<Database?> _initDB(String filePath) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'user.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
  await db.execute('''
    create table if not exists user ( 
      'id' integer primary key autoincrement,
      'first name' text not null, 
      'last name' text not null,
      'phone number' text not null,
      'email' text not null)
    ''');
  }
  readDate(String sql) async {
    Database? openDatabase = await database;
    List<Map> response = await openDatabase!.rawQuery(sql);
    return response;
  }

    insertDate(String sql) async {
    Database? openDatabase = await database;
    int response = await openDatabase!.rawInsert(sql);
    return response;
  }

  updateDate(String sql) async {
    Database? openDatabase = await database;
    int response = await openDatabase!.rawUpdate(sql);
    return response;
  }

  deleteDate(String sql) async {
    Database? openDatabase = await database;
    int  response = await openDatabase!.rawDelete(sql);
    return response;
  }

  resetDatabase() async{
    String dirPath = await getDatabasesPath();
    String path = join(dirPath, "user.db");
    deleteDatabase(path);
  }
 
}

