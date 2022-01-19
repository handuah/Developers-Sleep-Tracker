import 'package:bluespace_sleepers_app/models/employee_model.dart';
import 'package:bluespace_sleepers_app/utils/json_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      // ignore: recursive_getters
      // print('database here');
      return _database!;
    }

    _database = await initDB(employeeTable);
    print('database initialized');
    return _database!;
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER';
    final textType = "TEXT NOT NULL";
    final nullableText = "TEXT";
    final intType = "INTEGER NOT NULL";

    await db.execute('''
    CREATE TABLE $employeeTable (
      employee_id $idType,
      first_name $textType,
      last_name $textType,
      role $textType,
      age $intType,
      gender $textType,     
      sleep_count $intType,    
    )
    ''');

    for (int i = 0; i < employeeData.length; i++) {
      await db.insert(employeeTable, {
        'employee_id': employeeData[i]['employee_id'],
        'first_name': employeeData[i]['first_name'],
        'last_name': employeeData[i]['last_name'],
        'role': employeeData[i]['role'],
        'age': employeeData[i]['age'],
        'gender': employeeData[i]['gender'],
        'sleep_count': employeeData[i]['sleep_count'],
      });
    }
    await getEmployees();
  }

  Future<List<Employee>> getEmployees() async {
    final db = await instance.database;
    final allEmployees =
        await db.query(employeeTable, orderBy: 'first_name ASC');
    print(allEmployees);
    return allEmployees.map((e) => Employee.fromJson(e)).toList();
  }
}
