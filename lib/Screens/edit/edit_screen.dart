import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:armirene_rh_app/components/my_botton_nav_bar.dart';
import 'package:armirene_rh_app/constans.dart';
import '../../controllers/employee_controller.dart';
import 'package:armirene_rh_app/Screens/edit/components/body.dart';

class EditScreen extends StatelessWidget {
  EditScreen({super.key, required this.employee});
  EmployeeController employeeController = Get.find<EmployeeController>();
  final Map<String, dynamic> employee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: const Text('Editar Empleado'),
      ),
      body: Body(controllers: getControllers()),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }

  Map<String, TextEditingController> getControllers() {
    final map = <String, TextEditingController>{};
    employee.forEach((key, value) {
      map.addAll({key: TextEditingController(text: "$value")});
    });
    return map;
  }
}