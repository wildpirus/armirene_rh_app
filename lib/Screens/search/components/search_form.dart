import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:armirene_rh_app/constans.dart';
import 'package:armirene_rh_app/components/employee_card.dart';
import 'package:armirene_rh_app/components/input_dropdown.dart';
import '../../../controllers/employee_controller.dart';
import '../../home/home_screen.dart';

class SearchForm extends StatefulWidget {
  EmployeeController employeeController = Get.find<EmployeeController>();
  @override
  SearchFormState createState() => SearchFormState();
}

class SearchFormState extends State<SearchForm> {
  late Future<List<Widget>> shows;
  String searchString = "";

  final _searchKey = GlobalKey<FormState>();
  final _searchTextKey = TextEditingController();

  @override
  void initState() {
    super.initState();
    shows = getEmployeeCards();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: kPrimaryColor,
          child: Form(
            key: _searchKey,
            child: InputDropdown(
                textLabel: "Filtro",
                items: const [
                  "Primer Nombre",
                  "Otros Nombres",
                  "Primer Apellido",
                  "Segundo Apellido",
                  "Tipo de Identificación",
                  "Número de Identificación",
                  "País del empleo",
                  "Correo electrónico",
                  "Estado"
                ],
                controller: _searchTextKey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchString = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
                labelText: 'Search', suffixIcon: Icon(Icons.search)),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Widget>>(
              future: getEmployeeCards(),//shows,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                if (snapshot.hasData) {
                  final cards = snapshot.data ?? [];
                  return SingleChildScrollView(
                      child: Column(children: [...cards]));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Algo salió mal'));
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
              }),
        ),
      ],
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
