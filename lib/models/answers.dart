import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  final Function selectHandler;
  final String answerText;
  Answers(this.selectHandler, this.answerText);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 210,
        // child: IconButton(onPressed: selectHandler
        //   , icon: Image.asset('assets/icon/mood-sad.png', width: 35, height: 35),
        // ),
        child: ElevatedButton(
          child: Text(answerText),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(new Color(0xFFFDBC59)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )
              )
          ),
          onPressed: selectHandler,
        )
    );
  }
}
