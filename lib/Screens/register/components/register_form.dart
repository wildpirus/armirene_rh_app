import 'package:armirene_rh_app/domain/entities/employee.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import '../../../controllers/employee_controller.dart';
import 'package:armirene_rh_app/components/already_have_an_account_acheck.dart';
import 'package:armirene_rh_app/components/rounded_button.dart';
import 'package:armirene_rh_app/components/text_field_container.dart';
import 'package:armirene_rh_app/components/input_box.dart';
import 'package:armirene_rh_app/components/input_dropdown.dart';
import 'package:armirene_rh_app/components/datepicker_box.dart';
import 'package:armirene_rh_app/components/employee_card.dart';
import 'package:armirene_rh_app/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:armirene_rh_app/constans.dart';

class RegisterForm extends StatefulWidget {
  EmployeeController employeeController = Get.find<EmployeeController>();
  RegisterForm({super.key});
  /*const RegisterForm({
    Key? key,
  }) : super(key: key);*/
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {
    'firstName': TextEditingController(),
    'secondName': TextEditingController(),
    'lastName': TextEditingController(),
    'secondLastName': TextEditingController(),
    'idType': TextEditingController(),
    'country': TextEditingController(),
    'idNumber': TextEditingController(),
    'firstDay': TextEditingController(),
    'area': TextEditingController(),
    'status': TextEditingController(text: "Activo"),
    'registerDate': TextEditingController(
        text: formatDate(DateTime.now(),
            [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss])),
  };
  Employee epl = Employee(
      email: "victor@mail.com",
      firstName: "Victor",
      secondName: "Manuel",
      lastName: "Mendoza",
      secondLastName: "Ariza",
      idType: "CC",
      country: "Colombia",
      idNumber: "1001780049",
      firstDay: "01/03/2001",
      area: "area",
      status: "status",
      registerDate: "01/03/2001"
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //EmployeeCard(employee: epl.toJson()),
              InputBox(
                textLabel: "Primer Apellido",
                maxlength: 20,
                controller: controllers["lastName"],
                filter: "fullNameRegExp",
              ),
              InputBox(
                textLabel: "Segundo Apellido",
                maxlength: 20,
                controller: controllers["secondLastName"],
                filter: "fullNameRegExp",
              ),
              InputBox(
                textLabel: "Primer Nombre",
                maxlength: 20,
                controller: controllers["firstName"],
                filter: "fullNameRegExp",
              ),
              InputBox(
                  textLabel: "Otros Nombres",
                  maxlength: 50,
                  controller: controllers["secondName"],
                  filter: "fullNameRegExp",
                  isOptional: true),
              InputDropdown(
                textLabel: "Pais",
                items: const ["Colombia", "Estados Unidos"],
                controller: controllers["country"],
              ),
              InputDropdown(
                  textLabel: "Tipo de Identificacion",
                  items: const [
                    "C.C",
                    "Cedula Extranjera",
                    "Pasaporte",
                    "Permiso Especial"
                  ],
                  controller: controllers["idType"]),
              InputBox(
                textLabel: "Identificacion",
                maxlength: 20,
                controller: controllers["idNumber"],
                filter: "idRegExp",
              ),
              DatePickerBox(controller: controllers["firstDay"]),
              InputDropdown(
                  textLabel: "Area",
                  items: const [
                    "Administraci??n",
                    "Financiera",
                    "Compras",
                    "Infraestructura",
                    "Operaci??n",
                    "Talento Humano",
                    "Servicios Varios",
                  ],
                  controller: controllers["area"]),
              InputBox(
                  textLabel: "Estado",
                  isEnabled: false,
                  controller: controllers["status"]),
              InputBox(
                textLabel: "Fecha y hora de registro",
                value: formatDate(DateTime.now(),
                    [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]),
                isEnabled: false,
                controller: controllers["registerDate"],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          textStyle: const TextStyle(
                              letterSpacing: 2,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans')),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // final map = <String, dynamic>{};
                          final map = <String, dynamic>{'email': ""};
                          controllers.forEach((key, value) {
                            map.addAll({key: value.text});
                          });
                          await widget.employeeController.addEmployee(map);
                          Navigator.of(context).popUntil((route) => false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        }
                      },
                      child: const Text("Agregar",
                          style: TextStyle(color: Colors.white, fontSize: 17))))
            ],
          ),
        ));
  }
}
