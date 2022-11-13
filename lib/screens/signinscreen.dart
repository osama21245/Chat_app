import 'package:chat_app2/screens/chatscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/Dividerwidget.dart';
import '../widgets/IconRow.dart';
import '../widgets/button.dart';
import '../widgets/emailtextfield.dart';
import '../widgets/textfield.dart';
import '../widgets/textrow.dart';
import 'loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class Signinscreen extends StatefulWidget {
  const Signinscreen({super.key});
  @override
  static const screenRoute = '/signinscreen';

  @override
  State<Signinscreen> createState() => _SigninscreenState();
}

class _SigninscreenState extends State<Signinscreen> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = new TwitterLogin(
        apiKey: 'N9OfmadWRuWPm5gs8gmVbjgNC',
        apiSecretKey: 'KNCEYlYyOBFkpDgJB8XvvLr1Rv2y8MAdvRpSRQnB4nUTBJLRWG',
        redirectURI: 'flutter-twitter-login://');

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential);
  }

  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    String? password;
    String? email;
    bool showspiner = false;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showspiner,
        child: Container(
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
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            'signup',
                            style: TextStyle(
                                fontSize: 33,
                                fontFamily: 'myfont',
                                color: Colors.grey[800]),
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        SvgPicture.asset(
                          'icons/signup.svg',
                          height: size.height * 0.32,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 3),
                          child: emailtextfield(
                            onchange: (Value) {
                              email = Value;
                            },
                            size: size,
                            Title: 'Your Email:',
                            icon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 3),
                          child: passtextfield(
                            color: Color.fromARGB(255, 122, 122, 122),
                            onchange: (Value) {
                              password = Value;
                            },
                            size: size,
                            Title: 'Password:',
                            icon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Buttonwidget(
                            Title: 'signup',
                            color: Color.fromRGBO(186, 104, 200, 1),
                            ontap: () async {
                              setState(() {
                                showspiner = true;
                              });
                              if (formstate.currentState!.validate()) {
                              } else {
                                print("not valid");
                              }

                              try {
                                final newuser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email ?? "",
                                        password: password ?? "");
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  setState(() {
                                    showspiner = false;
                                  });
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.scale,
                                    title: 'Password is too weak',
                                    desc: 'at least 6 letters ',
                                    btnOkOnPress: () {},
                                  )..show();
                                } else if (e.code == 'email-already-in-use') {
                                  setState(() {
                                    showspiner = false;
                                  });
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.scale,
                                    title:
                                        'The account already exists for that email',
                                    desc: 'change th email ',
                                    btnOkOnPress: () {},
                                  )..show();
                                  print(
                                      'The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                              final newuser = _auth.currentUser;
                              print(newuser);
                              if (newuser != null) {
                                setState(() {
                                  showspiner = false;
                                });
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.scale,
                                    title: 'you make your account',
                                    btnOkOnPress: () {
                                      Navigator.pushNamed(
                                          context, Chatscreen.screenRoute);
                                    },
                                    btnOkText: 'login')
                                  ..show();
                              }
                            }),
                        SizedBox(
                          height: size.height * 0.023,
                        ),
                        TextRaw(),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        DiveWidget(size: size),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          width: size.width * 0.53,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    UserCredential cred =
                                        await signInWithFacebook();
                                    print(cred);
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: IconRow(
                                  photo: 'icons/facebook.svg',
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    UserCredential cred =
                                        await signInWithTwitter();
                                    print(cred);
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: IconRow(
                                  photo: 'icons/twitter.svg',
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    UserCredential cred =
                                        await signInWithGoogle();
                                    print(cred);
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: IconRow(
                                  photo: 'icons/google-plus.svg',
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Image.asset('images/signup_top.png'),
                height: 120,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
