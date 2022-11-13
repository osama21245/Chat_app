import 'package:chat_app2/screens/loginscreen.dart';
import 'package:chat_app2/screens/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/button.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  static const screenRoute = '/welcomescreen';
  Widget build(BuildContext context) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: 33,
                          fontFamily: 'myfont',
                          color: Colors.grey[800]),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SvgPicture.asset(
                    'icons/chat.svg',
                    height: size.height * 0.5,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Buttonwidget(
                      Title: 'login',
                      color: Color.fromARGB(255, 123, 31, 162),
                      ontap: () {
                        Navigator.pushNamed(context, Loginscreen.screenRoute);
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Buttonwidget(
                      Title: 'signup',
                      color: Color.fromARGB(255, 186, 104, 200),
                      ontap: () {
                        Navigator.pushNamed(context, Signinscreen.screenRoute);
                      })
                ],
              ),
            ),
            Positioned(
              child: Image.asset('images/main_top.png'),
              height: size.height * 0.17,
            ),
            Positioned(
              bottom: 0,
              child: Image.asset('images/main_bottom.png'),
              height: size.height * 0.13,
            )
          ],
        ),
      ),
    ));
  }
}
