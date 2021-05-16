import 'package:flutter/material.dart';

/*

Created a widget for app version. 
For future edits.

*/
class AppVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Text("version: 1.0.1"),
      ),
    );
  }
}
