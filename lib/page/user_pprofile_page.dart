import 'package:flutter/material.dart';
import 'package:flutter_auth2/widgets/app_version.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth_service.dart';
import '../main.dart';

/*
3/28/2021 Gary, Changed few positioned on the widget
*/
class UserProfile extends StatefulWidget {
  final nickname;
  UserProfile({this.nickname});
  @override
  _UserProfile createState() => _UserProfile(nickname: nickname);
}

class _UserProfile extends State<UserProfile> {
  final nickname;
  _UserProfile({this.nickname});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile', style: TextStyle(color: Colors.grey[850]),),
        actions: [
          // button sign out
          ElevatedButton(
            child: Row(children: <Widget>[
              Icon(
                Icons.logout,
                size: 26,
                color: Colors.white,
              ),
              Text('  Sign Out'),
            ]),
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
        ],
      ),
      body: Stack(
        //shrinkWrap: true,
        //padding: const EdgeInsets.all(20.0),
        children: [
          Text(
            "Hi $nickname!",
          ),

          // version display, for now hard coded, later should be grabbed from github release version
          // should be at the bottom of the screen
          AppVersion(),
        ],
      ),
    );
  }
}
