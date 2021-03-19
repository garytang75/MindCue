import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  final Function goMain;

  Results(this.resultScore, this.resetHandler, this.goMain);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 15) {
      resultText = 'You seems exhausted and sad, let\'s talk to me';
    } else if (resultScore <= 25) {
      resultText = 'You seems ok, think positive!';
    } else if (resultScore <= 30) {
      resultText = 'You are wonderful keep it up';
    } else {
      resultText = 'You are defintely well!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        FlatButton(
          child: Text('Do the questionaires again'),
          textColor: Colors.blue,
          onPressed: resetHandler,
        ),
        FlatButton(
          child: Text('Go back to the home page'),
          textColor: Colors.blue,
          onPressed: goMain,
        ),
        FlatButton(
            child: Text('Talk to me'),
            textColor: Colors.blue,
            onPressed: () {
              print('text widgets');
            })
      ],
    ));
  }
}
