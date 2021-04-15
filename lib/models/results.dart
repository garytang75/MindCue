import 'package:flutter/material.dart';
import 'package:flutter_auth2/widgets/bottom_app_bar.dart';
import 'package:flutter_auth2/widgets/circular_button.dart';

var resultT = "";

class Results extends StatelessWidget {
  final String resultTip;
  final Function resetHandler;
  final Function goMain;
  final int resultScore;

  Results(this.resultTip, this.resultScore, this.resetHandler, this.goMain);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 15) {
      resultText = 'You seems exhausted and sad, let\'s talk to me';
    } else if (resultScore <= 25) {
      resultText = 'You seems ok, think positive!';
    } else {
      resultText = 'You are wonderful! \n Keep it up and think positive! \n ';
    }
    // resultText =
    //     'You are wonderful! \n Keep it up and think positive! \n '; //'Would you like to get a tip based on your answers?\n'
    // print("resultTip: " + resultTip);
    return resultText + resultTip;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0, -.5),
            child: Text(
              resultPhrase,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Did something wrong? Try the questionaires again.'),
              FlatButton(
                padding: const EdgeInsets.all(18.0),
                child: Text('Do the questionaires again'),
                textColor: Colors.blue,
                onPressed: resetHandler,
              ),
              // FlatButton(
              //   child: Text('Go back to the home page'),
              //   textColor: Colors.blue,
              //   onPressed: goMain,
              // ),
            ]),
          ),

          //Bottom App Bar
          BottomApp(),
          Align(
            alignment: Alignment(0, 0.92),
            child: CircularButton(
              color: Color(0xFFFDBC59),
              width: 60,
              height: 60,
              icon: Icon(
                Icons.home_outlined,
                size: 30,
                color: Colors.black,
              ),
              onClick: goMain,
            ),
          ),
          //TODO add circular button in center(just like home page) with home icon that redirects to home
        ],
      ),
      // ],
      // FlatButton(
      //     child: Text('Talk to me'),
      //     textColor: Colors.blue,
      //     onPressed: () {
      //       print('text widgets');
      //     })
      // ],
    );
  }
}
