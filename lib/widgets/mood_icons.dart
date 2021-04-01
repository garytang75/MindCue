import 'package:flutter/material.dart';
var mood = "none"; //global variable

//pop up window offers user to chose mood icon. Displayed after entering text journal.
Widget popupMoodIcons(BuildContext context) {

  return new AlertDialog(
    title: const Text('How\'s your day?'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          IconButton(onPressed: () {
            mood = "mood-cry";
          },
           icon: Image.asset('assets/icon/mood-cry.png', width: 35, height: 35 ),
        ),
          IconButton(onPressed: () {
          mood = "mood-happy";
          },
            icon: Image.asset('assets/icon/mood-happy.png', width: 35, height: 35),
          ),
          IconButton(onPressed: () {
            mood = "mood-angry";
          },
            icon: Image.asset('assets/icon/mood-angry.png', width: 35, height: 35),
          ),
        ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
          IconButton(onPressed: () {
            mood = "mood-love";
          }, icon: Image.asset('assets/icon/mood-love.png', width: 35, height: 35),
          ),
          IconButton(onPressed: () {
            mood = "mood-sad";
          }, icon: Image.asset('assets/icon/mood-sad.png', width: 35, height: 35),
          ),
          IconButton(onPressed: () {
            mood = "mood-laugh";
          }, icon: Image.asset('assets/icon/mood-laugh.png', width: 35, height: 35),
          ),
        ],
        )
      ],
    ),
    actions: <Widget>[
      new ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();

        },
        child: const Text('Skip'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(new Color(0xFFFDBC59)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                  )
              )
          )
      ),
    ],
  );
}