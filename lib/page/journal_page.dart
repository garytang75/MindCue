import 'package:flutter/material.dart';

class JournalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Journal Page'),
        ),
        body: Center(
            child: ElevatedButton(
          child: Text('Journal Page'),
          onPressed: () {},
        )));
  }
}
