import 'package:chat_app2/screens/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User signinuser;

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  static const screenRoute = '/chatscreen';

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  @override
  void initState() {
    super.initState();

    getCurrentuser();
  }

  final _auth = FirebaseAuth.instance;
  final _firestor = FirebaseFirestore.instance;
  final messageedtingcontoolre = TextEditingController();

  String? YourMessage;

  void getCurrentuser() {
    final user = _auth.currentUser;

    try {
      if (user != null) {
        signinuser = user;

        print(signinuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    getmessages() async {
      await for (var snapshots
          in _firestor.collection('messages').snapshots()) {
        for (var messages in snapshots.docs) {
          print(messages.data());
        }
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await _auth.signOut();
                } catch (e) {
                  print(e);
                }

                Navigator.of(context).pushNamedAndRemoveUntil(
                    Welcomescreen.screenRoute, (route) => false);
              },
              icon: Icon(Icons.close))
        ],
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 209, 164, 219),
        title: Row(
          children: [
            Image.asset(
              'images/afd5a67f171d5d50cac17f307489c7fc.jpg',
              height: 60,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Chat ',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          messageStreambuilder(firestor: _firestor),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(255, 220, 145, 233), width: 3))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageedtingcontoolre,
                    onChanged: (Value) {
                      YourMessage = Value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Write Your Massge Here...',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                  child: TextButton(
                    onPressed: () {
                      messageedtingcontoolre.clear();
                      _firestor.collection('messages').add({
                        'text': YourMessage,
                        'sender': signinuser.email,
                        'time': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text('Send'),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 216, 122, 233)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class messageStreambuilder extends StatelessWidget {
  const messageStreambuilder({
    Key? key,
    required FirebaseFirestore firestor,
  })  : _firestor = firestor,
        super(key: key);

  final FirebaseFirestore _firestor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestor.collection('messages').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<sendline> messagewidget = [];

          if (!snapshot.hasData) {}

          final messages = snapshot.data!.docs.reversed;

          for (var message in messages) {
            final sendtext = message.get('text');
            final emailsender = message.get('sender');
            final currentuser = signinuser.email;

            final messageswidget = sendline(
              sendtext: sendtext,
              emailsender: emailsender,
              isMe: currentuser == emailsender,
            );

            messagewidget.add(messageswidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messagewidget,
            ),
          );
        });
  }
}

class sendline extends StatelessWidget {
  const sendline({
    Key? key,
    required this.sendtext,
    required this.emailsender,
    required this.isMe,
  }) : super(key: key);

  final String sendtext;
  final String emailsender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.01),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$emailsender',
            style: TextStyle(
                color: Color.fromARGB(255, 161, 113, 172), fontSize: 13),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isMe ? Colors.blue[800] : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01, horizontal: size.width * 0.02),
              child: Text(
                "$sendtext",
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.white : Colors.black45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
