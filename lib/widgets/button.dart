import 'package:flutter/material.dart';

class Buttonwidget extends StatelessWidget {
  Buttonwidget({
    required this.Title,
    required this.color,
    required this.ontap,
    Key? key,
  }) : super(key: key);
  Color color;
  String Title;
  VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: size.height * 0.05,
          minWidth: size.width * 0.75,
          child: Text(
            Title,
            style: TextStyle(color: Colors.white, fontSize: 27),
          ),
          onPressed: ontap),
    );
  }
}
