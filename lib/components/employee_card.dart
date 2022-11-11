import 'package:flutter/material.dart';
import '../../../controllers/employee_controller.dart';
import 'package:get/get.dart';
import '../Screens/edit/edit_screen.dart';

class EmployeeCard extends StatelessWidget {
  EmployeeCard({super.key, required this.employee, required this.onDelete});
  EmployeeController employeeController = Get.find<EmployeeController>();
  final Map<String, dynamic> employee;
  final onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Center(
          child: Row(children: <Widget>[
            CircleAvatar(
              radius: 30.0,
              backgroundColor: const Color(0xFF20283e),
              child: Text(getShortName(employee)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${employee['firstName']} ${employee['lastName']}",
                      // set some style to text
                      style: const TextStyle(
                          fontSize: 20.0, color: Colors.lightBlueAccent),
                    ),
                    Text(
                      employee['area'],
                      // set some style to text
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.amber),
                    ),
                    Text(
                      "${employee['email']}",
                      // set some style to text
                      style: const TextStyle(
                          fontSize: 12.0, color: Colors.lightBlue),
                    )
                  ],
                ),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: const Color(0xFF167F67),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditScreen(employee: employee)),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_forever,
                        color: const Color(0xFF167F67)),
                    onPressed: () async {
                      await onDelete();
                    },
                  )
                ]),
          ]),
        ),
      ),
    );
  }

  String getShortName(Map<String, dynamic> employee) {
    String shortName = "";
    if (employee['firstName'].isNotEmpty) {
      shortName = "${employee['firstName'].substring(0, 1)}.";
    }

    if (employee['lastName'].isNotEmpty) {
      shortName = shortName + employee['lastName'].substring(0, 1);
    }
    return shortName;
  }
}
