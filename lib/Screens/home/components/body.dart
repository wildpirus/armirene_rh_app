import 'package:armirene_rh_app/Screens/home/components/home_form.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: HomeForm(),
    );
  }
}
