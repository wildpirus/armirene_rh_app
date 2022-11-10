import 'dart:async';
import 'package:loggy/loggy.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/employee.dart';

class EmployeeLocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'employee_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE employees (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, firstName TEXT, secondName TEXT, lastName TEXT, secondLastName TEXT, idType TEXT, country TEXT, idNumber TEXT, firstDay TEXT, area TEXT, status TEXT, registerDate TEXT)');
  }

  Future<void> addEmployee(Employee employee) async {
    logInfo("ADD employee to db");
    final db = await database;

    await db.insert(
      'employees',
      employee.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    logInfo(employee.toJson());
  }

  Future<int> countEmails(Employee employee) async {
    final db = await database;

    List<Map<String, dynamic>> employees = await db.rawQuery(
        "SELECT * FROM employees WHERE firstName = '${employee.firstName}' AND lastName = '${employee.lastName}' AND country = '${employee.country}'");

    return employees.length;
  }

  Future<void> deleteEmployee(String id) async {
    logInfo("DELETE employee to db");
    final db = await database;

    await db.delete('employees', where: "id = ?", whereArgs: [id]);
  }

  Future<void> updateEmployee(Employee employee) async {
    logInfo("UPDATE employee to db");
    final db = await database;

    await db
        .update('employees', employee.toJson(), where: "id = ?", whereArgs: [employee.id]);

    logInfo(employee.toJson());
  }

  Future<Employee> getEmployee(String id) async {
    final db = await database;
    List<Map<String, dynamic>> employee =
        await db.query("employees", where: "id = ?", whereArgs: [id]);
    return Employee.fromJson(employee[0]);
  }

  Future<List<Map<String, dynamic>>> getAllEmployees() async {
    final db = await database;

    final List<Map<String, dynamic>> employees = await db.query('employees');

    return employees;
  }

  Future<void> deleteAll() async {
    Database db = await database;
    await db.delete('employees');
  }
}
