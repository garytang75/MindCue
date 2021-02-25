import 'package:flutter/material.dart';

class HelloWorld extends StatelessWidget {
  final VoidCallback shouldLogOut;
  HelloWorld({Key key, this.shouldLogOut})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: Center(
              child: Text('Hello World',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
        )
    );
  }
}
