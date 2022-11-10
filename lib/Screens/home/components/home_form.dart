import 'package:flutter/material.dart';
import 'package:armirene_rh_app/components/already_have_an_account_acheck.dart';
import 'package:armirene_rh_app/components/rounded_button.dart';
import 'package:armirene_rh_app/components/text_field_container.dart';
import 'package:armirene_rh_app/constans.dart';

class HomeForm extends StatelessWidget {
  const HomeForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10, bottom: 30),
            child: const Text(
              "ARMIRENE",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor
                  ),
            ),
          );
  }
}
