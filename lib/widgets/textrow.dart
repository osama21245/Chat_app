import 'package:chat_app2/screens/loginscreen.dart';
import 'package:flutter/material.dart';

class TextRaw extends StatelessWidget {
  const TextRaw({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an Account ?',
          style: TextStyle(fontSize: 15, color: Colors.grey[800]),
        ),
        SizedBox(
          //cloud_firestore: ^3.5.1
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Loginscreen.screenRoute);
          },
          child: Text(
            'Log in',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.purple[600]),
          ),
        )
      ],
    );
  }
}
