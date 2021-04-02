import 'package:flutter/material.dart';
import 'package:flutter_auth2/widgets/bottom_app_bar.dart';

var resultT = "";
class Results extends StatelessWidget {
  final String resultTip;
  final Function resetHandler;
  final Function goMain;

  Results(this.resultTip, this.resetHandler, this.goMain);

  String get resultPhrase{
    String resultText;
    resultText = 'You are wonderful! \n Keep it up and think positive! \n '; //'Would you like to get a tip based on your answers?\n'
    // print("resultTip: " + resultTip);
    return resultText + resultTip;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
          children: [
        Text(
        resultPhrase,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
              FlatButton(
                padding: const EdgeInsets.all(18.0),
                child: Text('Do the questionaires again'),
                textColor: Colors.blue,
                onPressed: resetHandler,
              ),
              FlatButton(
                child: Text('Go back to the home page'),
                textColor: Colors.blue,
                onPressed: goMain,
              ),
              ]),

            //Bottom App Bar
            BottomApp(),
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
