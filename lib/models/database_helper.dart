import 'dart:convert';

import 'package:bluespace_sleepers_app/models/employee_model.dart';
import 'package:bluespace_sleepers_app/utils/json_data.dart';
import 'package:flutter/services.dart';
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

    _database = await initDB('employees.db');
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

    await db.execute(
        "CREATE TABLE $employeeTable(employee_id $idType,first_name $textType,last_name $textType,role $textType,age $intType,gender $textType,sleep_count $intType)");

    // for (int i = 0; i < employeeData.length; i++) {
    //   await db.insert(employeeTable, {
    //     'employee_id': employeeData[i]['employee_id'],
    //     'first_name': employeeData[i]['first_name'],
    //     'last_name': employeeData[i]['last_name'],
    //     'role': employeeData[i]['role'],
    //     'age': employeeData[i]['age'],
    //     'gender': employeeData[i]['gender'],
    //     'sleep_count': employeeData[i]['sleep_count'],
    //   });
    // Batch batch = db.batch();
    // String employeesJson =
    //     await rootBundle.loadString('assets/json/employees.json');
    // List employeeList = json.decode(employeesJson);

    // // ignore: avoid_function_literals_in_foreach_calls
    // employeeList.forEach((val) {
    //   Employee employee = Employee.fromJson(val);
    //   // batch.insert(employeeTable, employee.toJson());
    //   // db.insert(employeeTable, employee.toJson());
    //   createEmployee(employee);
    // });
    // batch.commit();

    String employeeJson =
        await rootBundle.loadString('assets/json/employees.json');
    var employeeList = json.decode(employeeJson);
    var employeeMap = employeesFromMap(employeeList);
    // print(employeeMap);
    // print(employee);
    db.insert(employeeTable, employeeList);

    await getEmployees();
  }

  Future<List<Employee>> getEmployees() async {
    final db = await instance.database;
    final allEmployees =
        await db.query(employeeTable, orderBy: 'first_name ASC');

    List<Employee> employeesList =
        allEmployees.map((e) => Employee.fromJson(e)).toList();

    return employeesList;
  }

  Future<int> createEmployee(Employee employee) async {
    final db = await instance.database;
    return await db.insert(employeeTable, employee.toJson());
  }
}
