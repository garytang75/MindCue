import 'package:flutter/material.dart';
import 'package:flutter_auth2/page/journal_page.dart';
import 'package:flutter_auth2/page/user_pprofile_page.dart';
import '../fetch_data.dart';
import 'circular_button.dart';
import 'circular_animation.dart';

class BottomApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      alignment: Alignment.bottomCenter,
      child: Stack(children: [
        Container(
          width: 500,
          decoration: BoxDecoration(
              color: Colors.orange[100], shape: BoxShape.rectangle),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularButton(
                color: Colors.transparent,
                width: 50,
                height: 50,
                icon: Icon(Icons.menu_book, color: Colors.black),
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JournalPage()),
                  );
                },
              ),
              CircularButton(
                color: Colors.transparent,
                width: 50,
                height: 50,
                icon: Icon(Icons.bar_chart, color: Colors.black),
                onClick: () {
                  print('2');
                },
              ),
              CircularButton(
                color: Colors.transparent,
                width: 50,
                height: 50,
                icon: Icon(Icons.date_range, color: Colors.black),
                onClick: () {
                  print('2');
                },
              ),
              CircularButton(
                color: Colors.transparent,
                width: 50,
                height: 50,
                icon: Icon(Icons.more_horiz, color: Colors.black),
                onClick: () {
                  //get user nickname from Cognito
                  Fetch().fetchNickname().then((value) {
                    final nickname = value;
                    Navigator.push(
                      context,
                      //change page to user_profile page and pass userId
                      MaterialPageRoute(
                          builder: (context) =>
                              UserProfile(nickname: nickname)),
                    );
                  });
                },
              )
            ],
          ),
        ),
      ]),
    );
  }
}
