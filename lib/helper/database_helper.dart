import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final _tableName = "my_table";

  static final columnId = "_id";
  static final columnName = "name";
  static final columnAge = "age";

  var result;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  static Future<Database?> get database async {
    final databasePath = await getDatabasesPath();
    final status = await databaseExists(databasePath);
    if (!status) {
      _database = await openDatabase(join(databasePath, _databaseName),
          version: _databaseVersion, onCreate: (database, version) {
        return database.execute("CREATE TABLE $_tableName("
            "$columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
            "$columnName TEXT, "
            "$columnAge TEXT"
            ")");
      });
    }
    return _database;
  }

  Future<bool> insert(Map<String, dynamic> row) async {
    final db = await database;
    try {
      db!.insert(_tableName, row);
    } on Error {
      print("Error : $Error");
      throw Error();
    }
    return true;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await database;
    result = await db!.query(_tableName);
    return result.toList();
  }
}
