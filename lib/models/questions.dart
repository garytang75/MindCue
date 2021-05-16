import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  final String questionText;

  Questions(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(15),
        child: Text(
          questionText,

          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ));
  }
}
