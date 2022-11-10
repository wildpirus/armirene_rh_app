import 'package:flutter/material.dart';
import 'package:armirene_rh_app/constans.dart';
import 'package:armirene_rh_app/screens/home/home_screen.dart';
import './controllers/employee_controller.dart';
import './domain/repositories/employee_repository.dart';
import 'package:loggy/loggy.dart';
import './domain/use_case/employee_manager.dart';
import 'package:get/get.dart';


class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeController(), fenix: true);
    Get.lazyPut(() => EmployeeRepository(), fenix: true);
    Get.lazyPut(() => EmployeeManager(), fenix: true);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      title: 'ArmireneRhApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
