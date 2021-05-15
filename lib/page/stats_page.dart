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
            Image.asset('assets/icon/stats-icon.png', width: 35, height: 35),
          ],
        ), //Row
        title: Text(
            'Stats',
            style: TextStyle(color: Colors.grey[850]),
        )//Text
      )//AppBar

      body: Container (
        children: [
              Column (mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: []),
              //RawStatsDisplay(),
              EmotionOverTimeDisplay()
        ],
      )//Container
    );//Saffold
  }//build
}//StatsPage
