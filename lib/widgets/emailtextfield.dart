import 'package:flutter/material.dart';

class emailtextfield extends StatefulWidget {
  emailtextfield({
    Key? key,
    required this.size,
    required this.Title,
    required this.icon,
    required this.onchange,
  }) : super(key: key);

  final Size size;
  String Title;
  Icon icon;
  Function(String) onchange;

  @override
  State<emailtextfield> createState() => _passtextfieldState();
}

class _passtextfieldState extends State<emailtextfield> {
  bool showtext = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 225, 190, 231),
            borderRadius: BorderRadiusDirectional.circular(66)),
        width: widget.size.width * 0.68,
        child: TextFormField(
          validator: (value) {
            if (value!.length > 100) {
              return "Email  can't be larger than 100 letter";
            }
            if (value.length < 2) {
              return "Email  can't be less than 2 letter";
            }
          },
          onChanged: widget.onchange,
          obscureText: false,
          decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
              prefixIcon: widget.icon,
              hintText: widget.Title,
              border: InputBorder.none),
        ));
  }
}
