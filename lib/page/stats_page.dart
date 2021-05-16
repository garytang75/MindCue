import 'package:flutter/material.dart';
import '../widgets/emotion_over_time_display.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop())
              ],
            ), //Row
            title: Text(
              'Stats',
              style: TextStyle(color: Colors.grey[850]),
            ) //Text
            ), //AppBar
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [EmotionOverTimeDisplay()]),
        ) //Container
        ); //Saffold
  } //build
} //StatsPage
