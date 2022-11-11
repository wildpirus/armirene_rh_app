import '../domain/use_case/employee_manager.dart';
import 'package:get/get.dart';
import '../domain/entities/employee.dart';

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

  generateEmail(int countEmail, String country, String firstName, String lastName) {
    String domain = country == "Colombia" ? "armirene.com.co" : "armirene.com.us";
    String email;
    if (countEmail > 0) {
      email = "$firstName.$lastName.$countEmail@$domain";
    } else {
      email = "$firstName.$lastName@$domain";
    }
    return email;
  }
}