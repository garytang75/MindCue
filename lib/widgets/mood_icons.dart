import 'package:flutter/material.dart';

var mood = "none"; //global variable
String path = '';

//pop up window offers user to chose mood icon. Displayed after entering text journal.
Widget popupMoodIcons(BuildContext context) {
  return new AlertDialog(
    title: const Text('How\'s your day?'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {
                mood = "mood-cry";
                path = "assets/icon/mood-cry.png";
                Navigator.of(context).pop(path);
              },
              icon: Image.asset('assets/icon/mood-cry.png',
                  width: 35, height: 35),
            ),
            IconButton(
              onPressed: () {
                mood = "mood-happy";
                path = "assets/icon/mood-happy.png";
                Navigator.of(context).pop(path);
              },
              icon: Image.asset('assets/icon/mood-happy.png',
                  width: 35, height: 35),
            ),
            IconButton(
              onPressed: () {
                mood = "mood-angry";
                path = "assets/icon/mood-angry.png";
                Navigator.of(context).pop(path);
              },
              icon: Image.asset('assets/icon/mood-angry.png',
                  width: 35, height: 35),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {
                mood = "mood-love";
                path = "assets/icon/mood-love.png";
                Navigator.of(context).pop(path);
              },
              icon: Image.asset('assets/icon/mood-love.png',
                  width: 35, height: 35),
            ),
            IconButton(
              onPressed: () {
                mood = "mood-sad";
                path = "assets/icon/mood-sad.png";
                Navigator.of(context).pop(path);
              },
              icon: Image.asset('assets/icon/mood-sad.png',
                  width: 35, height: 35),
            ),
            IconButton(
              onPressed: () {
                mood = "mood-laugh";
                path = "assets/icon/mood-laugh.png";
                Navigator.of(context).pop(path);
              },
              icon: Image.asset('assets/icon/mood-laugh.png',
                  width: 35, height: 35),
            ),
          ],
        )
      ],
    ),
    actions: <Widget>[
      new ElevatedButton(
          onPressed: () {
            path = '';
            Navigator.of(context).pop();
          },
          child: const Text('Skip'),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(new Color(0xFFFDBC59)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )))),
    ],
  );
}
