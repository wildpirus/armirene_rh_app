import './edit_form.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.controllers});
  final Map<String, TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: EditForm(controllers: controllers),
    );
  }

}