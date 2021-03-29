import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth_service.dart';
import '../main.dart';


class UserProfile extends StatefulWidget {
  final nickname;
  UserProfile({this.nickname});
  @override
  _UserProfile createState() => _UserProfile(nickname:nickname);
}

class _UserProfile extends State<UserProfile> {
  final nickname;
  _UserProfile({this.nickname});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
        ),
        body: ListView(
        shrinkWrap: true,
    padding: const EdgeInsets.all(20.0),
    children: [
            Center(
              child: Text("Hi $nickname!")
            ),
            // button sign out
            ElevatedButton(
              child: Row(
              children: <Widget>[
                Icon(
                Icons.logout,
                size: 26,
                color: Colors.amber,
                ),
                Text('  Sign Out'),
              ]
              ),
              onPressed: () {
                AuthService().logOut();
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
              Fluttertoast.showToast(
              msg: "Signing off",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 12.0,
              );

              },

            ),
            // version display, for now hard coded, later should be grabbed from github release version
            // should be at the bottom of the screen
            Container(
                alignment: Alignment.bottomCenter,
                child: Text("version: 1.0.0"),
            ),
          ],
        ),
    );

  }
}
