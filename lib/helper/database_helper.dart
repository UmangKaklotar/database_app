import 'package:database_app/model/employee.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final databaseName = "MyDatabase.db";
  static final databaseVersion = 1;

  static final table = "my_table";

  static final columnId = "_id";
  static final columnName = "name";
  static final columnAge = "age";
  var result;

  // DatabaseHelper._privateConstructor();
  //
  // static final instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  static Future<Database?> get database async {
    final databasePath = await getDatabasesPath();
    final status = await databaseExists(databasePath);
    if(!status || status != null) {
      _database = await openDatabase(
        join(databasePath, databaseName),
        version: databaseVersion,
        onCreate: (database, version) {
          return database.execute(
            "CREATE TABLE $table($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnAge TEXT)"
          );
        }
      );
      return _database;
    }
  }

  insertData(Employee employee) async {
    final db = await database;
    await db!.insert(table, employee.toMap());
  }

  readData() async {
    final db = await database;
    result = await db!.query(table);
    print(result);
  }


  getEmployee() async {
    final db = await database;
    List<Map> list = await db!.rawQuery("SELECT * FROM $table");
    List<Employee> employee = [];
    for(int i = 0 ; i < list.length ; i++) {
      employee.add(Employee(name: list[i]['name'], age: list[i]['age']));
    }
    return employee;
  }

  updateData({Map<String, dynamic>? row, String? table, String? id}) async {
    final db = await database;
    await db!.update(table!, row!, where: "$columnId = ?", whereArgs: [id]);
  }

  deleteData(int id) async {
    final db = await database;
    await db!.delete(table, where: "$columnId = ?", whereArgs: [id]);
  }


}