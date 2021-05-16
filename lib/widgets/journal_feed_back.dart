import 'package:flutter/material.dart';
import '../page/journal_page.dart';

class JournalFeedback extends StatefulWidget {
  @override
  _JournalFeedbackState createState() => _JournalFeedbackState();
}

class _JournalFeedbackState extends State<JournalFeedback> {
  String myMood = '';

  void initState() {
    super.initState();
    myMood = 'Neutral';
  }

  @override
  Widget build(BuildContext context) {
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
                    getMood(),
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

  String getMood() {
    String currentMood = JournalPageState().getPath;
    if (currentMood != myMood) {
      if (currentMood == 'assets/icon/mood-laugh.png') {
        myMood = 'Happy';
      }
      if (currentMood == 'assets/icon/mood-sad.png') {
        myMood = 'Sad';
      }
      if (currentMood == 'assets/icon/mood-love.png') {
        myMood = 'Loved';
      }
      if (currentMood == 'assets/icon/mood-angry.png') {
        myMood = 'Angry';
      }
      if (currentMood == 'assets/icon/mood-happy.png') {
        myMood = 'Ok';
      }
      if (currentMood == 'assets/icon/mood-cry.png') {
        myMood = 'Blue';
      }
      return myMood;
    }
    return myMood;
  }
}
