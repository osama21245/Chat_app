import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app2/screens/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/textfield.dart';
import '../widgets/emailtextfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class awesomeee extends StatefulWidget {
  const awesomeee({super.key});

  static const screenRoute = '/awesome';
  @override
  State<awesomeee> createState() => _awesomeeeState();
}

class _awesomeeeState extends State<awesomeee> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    String? password;
    String? email;
    Size size = MediaQuery.of(context).size;
    bool showspiner = false;

    loginwithos() async {
      try {
        final newuser = await _auth.signInWithEmailAndPassword(
            email: email ?? "", password: password ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'user-not-found',
            desc: 'at least 6 letters ',
            btnOkOnPress: () {},
          )..show();
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'wrong-password',
            desc: 'change th email ',
            btnOkOnPress: () {},
          )..show();
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showspiner,
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            emailtextfield(
                onchange: (Value) {
                  email = Value;
                },
                size: size,
                Title: 'Your Email:',
                icon: Icon(Icons.person)),
            passtextfield(
                color: Color.fromARGB(255, 95, 95, 95),
                onchange: (Value) {
                  password = Value;
                },
                size: size,
                Title: 'Password:',
                icon: Icon(Icons.lock)),
            Container(
                child: TextButton(
              onPressed: () async {
                setState(() {
                  showspiner = true;
                });
              },
              child: Text('ooo'),
            )),
          ],
        )),
      ),
    );
  }
}
