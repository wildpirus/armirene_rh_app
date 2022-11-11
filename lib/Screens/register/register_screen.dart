import 'package:flutter/material.dart';
import 'package:armirene_rh_app/components/my_botton_nav_bar.dart';
import 'package:armirene_rh_app/constans.dart';
import 'package:armirene_rh_app/screens/register/components/body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: const Text('Registro de Empleado'),
      ),
      body: Body(),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}