import 'package:flutter/material.dart';
import 'package:flutter_auth2/widgets/bottom_app_bar.dart';
import 'package:flutter_auth2/widgets/circular_animation.dart';
import 'package:flutter_auth2/widgets/calendar.dart';
import 'package:flutter_auth2/models/journal.dart';

class HomePage extends StatelessWidget {
  final VoidCallback shouldLogOut;
  HomePage({Key key, this.shouldLogOut}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.face),
        title: Text('Mood Chart'),

      ),

      //Mock up for calendar and scrollable past journals
      body: Container(
          child: Stack(
        children: [
          Calendar(),
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              width: double.infinity,
              height: 0,
            ),
            Column(
              children: journals.map((jr) {
                return Card(
                    child: Row(
                  children: [
                    Column(children: [
                      Text(jr.userId),
                      SizedBox(
                        width: 300,
                        child: Text(
                          jr.journals,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(jr.createdAt.toString()),
                    ]),
                    Icon(Icons.sentiment_dissatisfied, color: Colors.red),
                  ],
                ));
              }).toList(),
            ),
          ]),
          //Bottom App Bar
          BottomApp(),
          //CircularAnimation Widget
          Positioned(bottom: 10, left: 100, child: CircularAnimation()),
        ],
      )),
    );
  }
}
