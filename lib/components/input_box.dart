import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final Map<String, Pattern> regexList = {
  'fullNameRegExp': RegExp(r'[A-Z]'),
  'idRegExp': RegExp(r'[a-zA-Z0-9-\-]')
};

class InputBox extends StatelessWidget {
  const InputBox(
      {super.key,
      required this.textLabel,
      this.maxlength,
      this.filter = '',
      this.isEnabled = true,
      this.isOptional = false,
      this.value,
      this.controller});

  final String textLabel;
  final int? maxlength;
  final String? filter;
  final bool? isEnabled;
  final bool isOptional;
  final String? value;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: TextFormField(
        controller: controller,
        maxLength: maxlength,
        enabled: isEnabled,
        validator: (value) {
          if (value == null || value.isEmpty && !isOptional) {
            return 'Debe ingresar texto';
          }
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(regexList[filter] ?? RegExp(r'')),
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(), 
          labelText: textLabel,
          hintText: 'Ingrese $textLabel',
          labelStyle: const TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black),
        ),
      ),
    );
  }
}
