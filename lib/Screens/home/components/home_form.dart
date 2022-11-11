import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:armirene_rh_app/constans.dart';
import 'package:armirene_rh_app/components/employee_card.dart';
import '../../../controllers/employee_controller.dart';
import '../home_screen.dart';

class HomeForm extends StatefulWidget {
  EmployeeController employeeController = Get.find<EmployeeController>();
  @override
  HomeFormState createState() => HomeFormState();
}

class HomeFormState extends State<HomeForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<Widget>>(
      future: getEmployeeCards(),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        if (snapshot.hasData) {
          final cards = snapshot.data ?? [];
          return SingleChildScrollView(child: Column(children: [...cards]));
        }
        return Container(
          width: size.width,
          height: size.height * 0.8,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10, bottom: 30),
          child: const Text(
            "ARMIRENE",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
          ),
        );
      },
    );
  }

  Future<List<Widget>> getEmployeeCards() async {
    final employees = await widget.employeeController.getAllEmployees();
    final employeeList = List.generate(
        employees.length,
        (index) => EmployeeCard(
            employee: employees[index],
            onDelete: () async {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('¿Esta seguro de eliminar al empleado?'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ElevatedButton(
                                child: const Text('Cancelar'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            ElevatedButton(
                              child: const Text('Confirmar'),
                              onPressed: () async {
                                await widget.employeeController
                                    .deleteEmployee(employees[index]);
                                Navigator.of(context)
                                    .popUntil((route) => false);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              },
                            ),
                          ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            })).toList();
    return employeeList;
  }
}
