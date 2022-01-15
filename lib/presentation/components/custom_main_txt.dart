import 'package:flutter/material.dart';

class CustomLineTxt extends StatelessWidget {
  final String txt;
  const CustomLineTxt({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
      child: Text(
        txt,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }
}
