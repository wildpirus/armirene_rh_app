import 'package:armirene_rh_app/Screens/register/components/register_form.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RegisterForm(),
    );
  }
}