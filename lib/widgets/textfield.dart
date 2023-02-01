import 'package:flutter/material.dart';

class passtextfield extends StatefulWidget {
  passtextfield(
      {Key? key,
      required this.size,
      required this.Title,
      required this.icon,
      required this.color,
      required this.mycontrooler})
      : super(key: key);
  TextEditingController mycontrooler;
  Color color;
  final Size size;
  String Title;
  Icon icon;

  @override
  State<passtextfield> createState() => _passtextfieldState();
}

class _passtextfieldState extends State<passtextfield> {
  bool showtext = true;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 225, 190, 231),
            borderRadius: BorderRadiusDirectional.circular(66)),
        width: widget.size.width * 0.68,
        child: TextFormField(
          controller: widget.mycontrooler,
          validator: (value) {
            if (value!.length > 100) {
              return "Password can't be larger than 100 letter";
            }
            if (value.length == 0) {
              return "This field can`t be empty";
            }
            if (value.length < 4) {
              return "Password  can't be less than 4 letter";
            }
          },
          obscureText: showtext,
          decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
              prefixIcon: widget.icon,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showtext = !showtext;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye, color: widget.color)),
              hintText: widget.Title,
              border: InputBorder.none),
        ));
  }
}
