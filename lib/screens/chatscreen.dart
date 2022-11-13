import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  late User signinuser;
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
              onPressed: () {
                // try {
                //   await _auth.signOut();
                // } catch (e) {
                //   print(e);
                // }

                // Navigator.pop(context);

                getmessages();
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
          StreamBuilder<QuerySnapshot>(
              stream: _firestor.collection('messages').snapshots(),
              builder: (context, snapshot) {
                List<sendline> messagewidget = [];

                if (!snapshot.hasData) {}

                final messages = snapshot.data!.docs;

                for (var message in messages) {
                  final sendtext = message.get('text');
                  final emailsender = message.get('sender');
                  final messageswidget =
                      sendline(sendtext: sendtext, emailsender: emailsender);

                  messagewidget.add(messageswidget);
                }
                return Expanded(
                  child: ListView(
                    children: messagewidget,
                  ),
                );
              }),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(255, 220, 145, 233), width: 3))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
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
                      _firestor.collection('messages').add(
                          {'text': YourMessage, 'sender': signinuser.email});
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

class sendline extends StatelessWidget {
  const sendline({
    Key? key,
    required this.sendtext,
    required this.emailsender,
  }) : super(key: key);

  final String sendtext;
  final String emailsender;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.01),
      child: Column(
        children: [
          Text('$emailsender'),
          Material(
            color: Colors.blue[800],
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01, horizontal: size.width * 0.02),
              child: Text(
                "$sendtext-$emailsender",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
