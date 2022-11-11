import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:armirene_rh_app/constans.dart';
import 'package:armirene_rh_app/components/employee_card.dart';
import 'package:armirene_rh_app/components/input_dropdown.dart';
import '../../../controllers/employee_controller.dart';
import '../../home/home_screen.dart';
import 'package:armirene_rh_app/domain/entities/employee.dart';

const List<String> list = <String>[
  "Primer Nombre",
  "Otros Nombres",
  "Primer Apellido",
  "Segundo Apellido",
  "Tipo de Identificación",
  "Número de Identificación",
  "País del empleo",
  "Correo electrónico",
  "Estado"
];

class SearchForm extends StatefulWidget {
  EmployeeController employeeController = Get.find<EmployeeController>();
  @override
  SearchFormState createState() => SearchFormState();
}

class SearchFormState extends State<SearchForm> {
  late Future<List<Employee>> shows;
  String searchString = "";
  String dropdownValue = list.first;

  @override
  void initState() {
    super.initState();
    shows = fetchEmp();
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
          child: Container(
            alignment: AlignmentDirectional.centerEnd,
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.8,
            child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                alignment: AlignmentDirectional.centerEnd,
                style: const TextStyle(
                    color: Colors.black),
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
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
          child: FutureBuilder(
            builder: (context, AsyncSnapshot<List<Employee>> snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return snapshot.data![index]
                              .toJson()[getFieldCode(dropdownValue)]
                              .toLowerCase()
                              .contains(searchString)
                          ? EmployeeCard(
                              employee: snapshot.data![index].toMap(),
                              onDelete: () async {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 200,
                                      color: Colors.white,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text(
                                                '¿Esta seguro de eliminar al empleado?'),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: ElevatedButton(
                                                    child:
                                                        const Text('Cancelar'),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  child:
                                                      const Text('Confirmar'),
                                                  onPressed: () async {
                                                    await widget
                                                        .employeeController
                                                        .deleteEmployee(snapshot
                                                            .data![index]
                                                            .toMap());
                                                    Navigator.of(context)
                                                        .popUntil(
                                                            (route) => false);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen()),
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
                              })
                          : Container();
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return snapshot.data![index]
                              .toJson()[getFieldCode(dropdownValue)]
                              .toLowerCase()
                              .contains(searchString)
                          ? Divider()
                          : Container();
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went wrong :('));
              }
              return CircularProgressIndicator();
            },
            future: shows,
          ),
        ),
      ],
    );
  }

  Future<List<Employee>> fetchEmp() async {
    final res = await widget.employeeController.getAllEmployees();
    return res.map((e) => Employee.fromJson(e)).toList();
  }

  String getFieldCode(String s) {
    switch (s) {
      case "Primer Nombre":
        {
          return 'firstName';
        }
      case "Otros Nombres":
        {
          return 'secondName';
        }
      case "Primer Apellido":
        {
          return 'lastName';
        }
      case "Segundo Apellido":
        {
          return 'secondLastName';
        }
      case "Tipo de Identificación":
        {
          return 'idType';
        }
      case "Número de Identificación":
        {
          return 'idNumber';
        }
      case "País del empleo":
        {
          return 'country';
        }
      case "Correo electrónico":
        {
          return 'email';
        }
      case "Estado":
        {
          return 'status';
        }
      default:
        {
          return 'lastName';
        }
    }
  }
}
