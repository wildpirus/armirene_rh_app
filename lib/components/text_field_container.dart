import "package:flutter/material.dart";

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer(
      {super.key,
      required this.text,
      required this.inputColor,
      required this.textColor,
      required this.icon});

  final String text;
  final Color inputColor, textColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: inputColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(29)),
      child: TextField(
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: inputColor,
            ),
            hintText: text,
            border: InputBorder.none),
      ),
    );
  }
}
