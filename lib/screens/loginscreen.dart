import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app2/screens/chatscreen.dart';
import 'package:chat_app2/screens/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/button.dart';
import '../widgets/emailtextfield.dart';
import '../widgets/textfield.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  static const screenRoute = '/loginscreen';

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    final _auth = FirebaseAuth.instance;
    TextEditingController password = TextEditingController();

    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Form(
                  key: formstate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Text(
                          'login',
                          style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'myfont',
                              color: Colors.grey[800]),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SvgPicture.asset(
                        'icons/login.svg',
                        height: size.height * 0.37,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 3),
                        child: emailtextfield(
                            mycontroler: email,
                            size: size,
                            Title: 'Your Email:',
                            icon: Icon(Icons.person)),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 3),
                        child: passtextfield(
                            color: Color.fromARGB(255, 95, 95, 95),
                            mycontrooler: password,
                            size: size,
                            Title: 'Password:',
                            icon: Icon(Icons.lock)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Buttonwidget(
                          Title: 'login',
                          color: Color.fromARGB(255, 186, 104, 200),
                          ontap: () async {
                            if (formstate.currentState!.validate()) {
                            } else {
                              print("not valid");
                            }
                            final newuser =
                                await _auth.signInWithEmailAndPassword(
                                    email: email.text, password: password.text);
                            print(newuser);
                            if (newuser != null) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  Chatscreen.screenRoute, (route) => false);
                            }
                          }),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dont have an Account ?',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[800]),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Signinscreen.screenRoute);
                            },
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.purple[600]),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              child: Image.asset('images/main_top.png'),
              height: 150,
            ),
          ],
        ),
      ),
    ));
  }
}
