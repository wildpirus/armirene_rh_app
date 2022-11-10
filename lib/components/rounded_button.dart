import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.text,
      required this.press,
      required this.color,
      required this.textColor});

  final String text;
  final Function press;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          onPressed: press(),
          style: TextButton.styleFrom(
              backgroundColor: color,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
