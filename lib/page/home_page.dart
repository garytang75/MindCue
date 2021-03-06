import 'package:flutter/material.dart';
import 'package:flutter_auth2/widgets/bottom_app_bar.dart';
import 'package:flutter_auth2/widgets/circular_animation.dart';
import 'package:flutter_auth2/widgets/calendar.dart';

import 'package:flutter_auth2/widgets/tip_display.dart';
import '../journal_service.dart';

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
          'Home',
          style: TextStyle(color: Colors.grey[850]),
        ),
      ),

      //Mock up for calendar and scrollable past journals
      body: Container(
          child: Stack(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0, bottom: 100.0),
              child: FutureBuilder<String>(
                  future: TextJournal().getSentiment(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sentiment of your last journal:",
                                style: TextStyle(
                                    fontSize: 20,
                                    height: 4,
                                    color: Color(0xFF87bdde),
                                    fontWeight: FontWeight.bold)),
                            Text(snapshot.data, style: TextStyle(fontSize: 16)),
                          ]);
                    }
                    return Column(
                      children: [
                        Text("No sentiment data yet",
                            style: TextStyle(
                                fontSize: 20,
                                height: 4,
                                color: Color(0xFF87bdde),
                                fontWeight: FontWeight.bold)),
                        Text("create new journal entry for analysis",
                            style: TextStyle(fontSize: 15)),
                      ],
                    );
                  }),
            ),
          ]),

          Calendar(),

          //Tip
          TipDisplay(),

          //JournalFeedback(),
          //Bottom App Bar

          BottomApp(),
          //CircularAnimation Widget
          CircularAnimation(),
        ],
      )),
    );
  }

  Widget journalFeedBack() {
    return Align(
      alignment: Alignment(0, -0.3),
      child: Container(
          margin: const EdgeInsets.all(25),
          // decoration:
          //     BoxDecoration(border: Border.all(color: Color(0xFFCEE2EE))),
          width: double.infinity,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Based on your journal entry',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text('You felt',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    ' Stressed',
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFFe3a600),
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget tipTable() {
    return Align(
        alignment: Alignment(0, 0.8),
        child: Container(
            margin: const EdgeInsets.all(10.0),
            width: double.infinity,
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Let\'s try these:'),
                Text('Tips'),
              ],
            )));
  }
}
