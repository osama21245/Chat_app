// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chat_app2/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
 passtextfield(
                          color: Color.fromARGB(255, 122, 122, 122),
                          onchange: (Value) {
                            password = Value;
                          },
                          size: size,
                          Title: 'Password:',
                          icon: Icon(Icons.lock),
                        ),

                        import 'package:flutter/material.dart';

class passtextfield extends StatefulWidget {
  passtextfield(
      {Key? key,
      required this.size,
      required this.Title,
      required this.icon,
      required this.onchange,
      required this.color})
      : super(key: key);
  Color color;
  final Size size;
  String Title;
  Icon icon;
  Function(String) onchange;

  @override
  State<passtextfield> createState() => _passtextfieldState();
}

class _passtextfieldState extends State<passtextfield> {
  bool showtext = true;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formstate,
      child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 225, 190, 231),
              borderRadius: BorderRadiusDirectional.circular(66)),
          width: widget.size.width * 0.68,
          child: TextFormField(
            validator: (value) {
              if (value!.length > 100) {
                return "Password  can't be larger than 100 letter";
              }
              if (value.length < 4) {
                return "Password  can't be less than 4 letter";
              }
            },
            onChanged: widget.onchange,
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
          )),
    );
  }
}
