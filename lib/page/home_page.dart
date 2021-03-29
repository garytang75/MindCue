import 'package:flutter/material.dart';
import 'package:flutter_auth2/widgets/bottom_app_bar.dart';
import 'package:flutter_auth2/widgets/circular_animation.dart';
import 'package:flutter_auth2/widgets/calendar.dart';
import 'package:flutter_auth2/models/journal.dart';

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
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: []),

          Calendar(),
          //Bottom App Bar
          BottomApp(),
          //CircularAnimation Widget
          CircularAnimation(),
        ],
      )),
    );
  }
}
