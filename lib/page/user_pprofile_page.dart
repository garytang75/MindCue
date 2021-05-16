import 'package:flutter/material.dart';
import 'package:flutter_auth2/morepage/faq_page.dart';
import 'package:flutter_auth2/morepage/privacy_notice.dart';
import 'package:flutter_auth2/morepage/terms_and_condition.dart';
import 'package:flutter_auth2/widgets/app_version.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';

import '../account_removal.dart';
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
                          new Color(0xFF751CC3)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        //change page to user_profile page and pass userId
                        MaterialPageRoute(builder: (context) => FaqPage()),
                      );
                    },
                  ),
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
                          new Color(0xFF348015)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        //change page to user_profile page and pass userId
                        MaterialPageRoute(
                            builder: (context) => TermsAndCondition()),
                      );
                    },
                  ),
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
                          new Color(0xFF8FC2E1)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        //change page to user_profile page and pass userId
                        MaterialPageRoute(
                            builder: (context) => PrivacyNotice()),
                      );
                    },
                  ),
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
                            new Color(0xFFF19679)),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => CupertinoAlertDialog(
                                  title: Text("Delete your account?"),
                                  content: Text(
                                      "We are happy to let you go because we hope you are feeling better. It's been a long journey. Thank you for using MindCue from the dev team.",
                                      textAlign: TextAlign.center),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                          "Goodbye, I am feeling a lot better!"),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        AccountDeletion().deleteUser();
                                        AuthService().logOut();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyApp()),
                                        );
                                        Fluttertoast.showToast(
                                          msg: "Account will be deleted",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 12.0,
                                        );
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                        "Maybe, I will keep the app just in case.",
                                      ),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                    )
                                  ],
                                ),
                            barrierDismissible: true);
                      }),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment(0, .7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("We care about your mental well-being",
                    style: TextStyle(
                        fontSize: 20,
                        height: 1.5,
                        color: Color(0xFFe3a600),
                        fontWeight: FontWeight.bold)),
                Text(
                  "As we understand, life can be difficult sometimes. If you need further help, please don't be afraid to reach out.",
                  style: TextStyle(fontSize: 15, height: 1, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: Image.asset("assets/icon/MentalHealth.jpg"),
                  ),
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
