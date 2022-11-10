import '../domain/use_case/employee_manager.dart';
import 'package:get/get.dart';
import '../domain/entities/employee.dart';
import '../domain/repositories/employee_repository.dart';
import '../utils/utils.dart';
import '../domain/use_case/employee_manager.dart';

class EmployeeController extends GetxController {
  EmployeeManager _useCase = Get.find<EmployeeManager>();

  final employees = <Employee>[].obs;

  Future<Employee> getEmployee(Map<String, dynamic> employee) async {
    return await _useCase.getEmployee(Employee.fromJson(employee));
  }

  Future<void> addEmployee(Map<String, dynamic> employee) async {
    int countEmail = await _useCase.countEmails(Employee.fromJson(employee));
    employee["email"] = generateEmail(
        countEmail, employee["country"], employee["firstName"], employee["lastName"]);
    await _useCase.addEmployee(Employee.fromJson(employee));
  }

  Future<void> updateEmployee(Map<String, dynamic> employee) async {
    int countEmail = await _useCase.countEmails(Employee.fromJson(employee));
    employee["email"] = generateEmail(
        countEmail, employee["country"], employee["firstName"], employee["lastName"]);
    await _useCase.updateEmployee(Employee.fromJson(employee));
  }

  Future<void> deleteEmployee(Map<String, dynamic> employee) async {
    await _useCase.deleteEmployee(Employee.fromJson(employee));
  }

  Future<List<Map<String, dynamic>>> getAllEmployees() async {
    return await _useCase.getAllEmployees();
  }
}