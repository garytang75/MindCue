import 'package:flutter/material.dart';
import 'package:flutter_auth2/widgets/bottom_app_bar.dart';
import 'package:flutter_auth2/widgets/circular_animation.dart';
import 'package:flutter_auth2/widgets/calendar.dart';
import 'package:flutter_auth2/models/journallocal.dart';

class HomePage extends StatelessWidget {
  final VoidCallback shouldLogOut;
  HomePage({Key key, this.shouldLogOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image.asset('assets/icon/main-icon.png', width: 35, height: 35),
          ],
        ),
        title: Text(
          'Mood Chart',
          style: TextStyle(color: Colors.grey[850]),
        ),
      ),

      //Mock up for calendar and scrollable past journals
      body: Container(
          child: Stack(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: []),

          Calendar(),
          //Bottom App Bar
          BottomApp(),
          //CircularAnimation Widget
          CircularAnimation(),

        ],
      )),
    );
  }
}
