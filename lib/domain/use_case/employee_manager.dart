import 'package:get/get.dart';
import '../entities/employee.dart';
import '../repositories/employee_repository.dart';

// this file handles the business logic, calling the corresponding repository
class EmployeeManager {
  EmployeeRepository repository = Get.find<EmployeeRepository>();

  Future<void> addEmployee(Employee employee) async => await repository.addEmployee(employee);

  Future<void> updateEmployee(Employee employee) async => await repository.updateEmployee(employee);

  Future<void> deleteEmployee(Employee employee) async => await repository.deleteEmployee(employee);

  Future<Employee> getEmployee(Employee employee) async => await repository.getEmployee(employee);

  Future<int> countEmails(Employee employee) async =>
      await repository.countEmails(employee);

  Future<List<Map<String, dynamic>>> getAllEmployees() async =>
      await repository.getAllEmployees();
}