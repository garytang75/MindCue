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
        title: Text(
          'Hey $nickname!',
          style: TextStyle(color: Colors.grey[850]),
        ),
        actions: [
          // button sign out
          TextButton(
            child: Row(children: <Widget>[
              Icon(
                Icons.logout,
                size: 24,
                color: Colors.white,
              ),
              Text(
                'Sign Out',
                style: TextStyle(color: Colors.grey[850]),
              ),
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
        // padding: const EdgeInsets.all(20.0),

        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.announcement_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          '  About',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            new Color(0xFFFDBC59)),
                      ),
                      onPressed: () {
                        showAboutDialog(
                            context: context,
                            applicationVersion: '1.0.0',
                            applicationIcon: Image.asset(
                              'assets/icon/mindcue.png',
                            ),
                            children: [
                              Text(
                                  'MindCue helps tracking mental well-being and reduce stress factors, develop self-awareness and healthy habits.'),
                            ]);
                      }),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.question_answer_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          '  FAQ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            new Color(0xFFb7c0c4)),
                      )),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.article_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          '  Terms & Conditions',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            new Color(0xFFb7c0c4)),
                      )),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.account_circle_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          '  Privacy Policy',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            new Color(0xFFb7c0c4)),
                      )),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.delete_forever,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          '  Delete Account',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            new Color(0xFFb7c0c4)),
                      )),
                ),
              ],
            ),
          ),
          // version display, for now hard coded, later should be grabbed from github release versio
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppVersion(),
          ),
        ],
      ),
    );
  }
}
