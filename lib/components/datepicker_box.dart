import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';

class DatePickerBox extends StatefulWidget {
  const DatePickerBox({super.key, this.controller});
  final TextEditingController? controller;

  @override
  State<DatePickerBox> createState() => _DatePickerBoxState();
}

class _DatePickerBoxState extends State<DatePickerBox> {
  String _value = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: TextFormField(
        controller: widget.controller,
        onChanged: (String? change) {
          _showDatePicker(context);
        },
        onTap: () {
          _showDatePicker(context);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Debes seleccionar una opcion';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Fecha de Ingreso",
          labelStyle: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black),
        ),
      ),
    );
  }

  _showDatePicker(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        maxTime: DateTime.now(),
        minTime: DateTime.now().subtract(const Duration(days: 30)),
        onChanged: (date) {}, onConfirm: (date) {
      setState(() {
        _value = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]);
        widget.controller!.text = _value;
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
}
