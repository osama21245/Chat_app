import 'package:flutter/material.dart';

class DiveWidget extends StatelessWidget {
  const DiveWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 2,
              color: Colors.purple[600],
            ),
          ),
          Text(
            'OR',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.purple[600]),
          ),
          Expanded(
              child: Divider(
            thickness: 2,
            color: Colors.purple[800],
          ))
        ],
      ),
    );
  }
}
