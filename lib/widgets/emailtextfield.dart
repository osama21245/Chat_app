import 'package:flutter/material.dart';

class emailtextfield extends StatelessWidget {
  emailtextfield(
      {Key? key,
      required this.size,
      required this.Title,
      required this.icon,
      required this.mycontroler})
      : super(key: key);

  TextEditingController mycontroler;

  final Size size;
  String Title;
  Icon icon;

  bool showtext = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 225, 190, 231),
            borderRadius: BorderRadiusDirectional.circular(66)),
        width: size.width * 0.68,
        child: TextFormField(
          controller: mycontroler,
          validator: (value) {
            if (value!.length > 100) {
              return "Email  can't be larger than 100 letter";
            }
            if (value.length == 0) {
              return "This field can`t be empty";
            }
            if (value.length < 2) {
              return "Email  can't be less than 2 letter";
            }
          },
          obscureText: false,
          decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
              prefixIcon: icon,
              hintText: Title,
              border: InputBorder.none),
        ));
  }
}
