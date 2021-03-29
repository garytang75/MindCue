import 'package:flutter/material.dart';
import 'package:flutter_auth2/main.dart';
import 'package:flutter_auth2/page/login_page.dart';
import 'package:flutter_auth2/widgets/bottom_app_bar.dart';
import 'package:flutter_auth2/widgets/circular_animation.dart';
import 'package:flutter_auth2/widgets/calendar.dart';
import 'package:flutter_auth2/models/journal.dart';
import 'package:flutter_auth2/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  final VoidCallback shouldLogOut;
  HomePage({Key key, this.shouldLogOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.face),
        title: Text('Mood Chart'),
        // actions: [
        //   Padding(
        //       padding: EdgeInsets.only(right: 20.0),
        //       child: TextButton(
        //         onPressed: () {
        //           AuthService().logOut();
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => MyApp()),
        //           );
        //           Fluttertoast.showToast(
        //             msg: "Signing off",
        //             toastLength: Toast.LENGTH_SHORT,
        //             gravity: ToastGravity.BOTTOM,
        //             timeInSecForIosWeb: 1,
        //             fontSize: 12.0,
        //           );
        //         },
        //         child: Icon(
        //           Icons.logout,
        //           size: 26,
        //           color: Colors.amber,
        //         ),
        //       ))
        // ],
      ),

      //Mock up for calendar and scrollable past journals
      body: Container(
          child: Stack(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              children: journals.map((jr) {
                return Card(
                    child: Row(
                  children: [
                    Column(children: [
                      Text(jr.userId),
                      SizedBox(
                        width: 300,
                        child: Text(
                          jr.journals,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(jr.createdAt.toString()),
                    ]),
                    Icon(Icons.sentiment_dissatisfied, color: Colors.red),
                  ],
                ));
              }).toList(),
            ),
          ]),
          Calendar(),
          //Bottom App Bar
          BottomApp(),
          //CircularAnimation Widget
          Positioned(bottom: 10, left: 100, child: CircularAnimation()),
        ],
      )),
    );
  }
}
