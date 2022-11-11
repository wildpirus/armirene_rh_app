import 'package:loggy/loggy.dart';
import '../../data/datasources/employee_local_datasource_sqflite.dart';
import '../entities/employee.dart';

// here we call the corresponding local source
class EmployeeRepository {
  late EmployeeLocalDataSource localDataSource;

  EmployeeRepository() {
    logInfo("Starting EmployeeRepository");
    localDataSource = EmployeeLocalDataSource();
  }

  Future<void> addEmployee(Employee employee) async {
    await localDataSource.addEmployee(employee);
  }

  Future<void> updateEmployee(Employee employee) async {
    await localDataSource.updateEmployee(employee);
  }

  Future<void> deleteEmployee(Employee employee) async {
    await localDataSource.deleteEmployee("${employee.id}");
  }

  Future<Employee> getEmployee(Employee employee) async {
    return await localDataSource.getEmployee("${employee.id}");
  }

  Future<int> countEmails(Employee employee) async {
    return await localDataSource.countEmails(employee);
  }

  Future<List<Map<String, dynamic>>> getAllEmployees() async =>
      await localDataSource.getAllEmployees();
}
