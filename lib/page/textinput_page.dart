import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_auth2/widgets/mood_icons.dart';
import 'package:intl/intl.dart';

import '../fetch_data.dart';
import '../journal_service.dart';

class TextInput extends StatefulWidget {
  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  TextEditingController _journalController = TextEditingController();

  moodIconAlert(BuildContext context) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return popupMoodIcons(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Text me',
            style: TextStyle(color: Colors.grey[850]),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: TextField(
                    controller: _journalController,
                    decoration: InputDecoration(
                      hintText: "Tell me how you feel today",
                    ),
                    maxLines: null,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      moodIconAlert(context);
                      var formatDate = DateFormat('MM-dd-yyyy');
                      var formatTime = DateFormat.jm();
                      var date = formatDate.format(
                          DateTime.now()); //date to display with journal
                      var time = formatTime.format(
                          DateTime.now()); //time to display with journal
                      var dateTime =
                          DateTime.now().toString(); //date and time for DB

                      //TODO following function should be called after moodIconAlert result
                      mood = "none";
                      Journal().sendDairy(_journalController.text, dateTime);
                      print(_journalController.text);
                      _journalController.text = "";
                      Fluttertoast.showToast(
                          msg: "Your feeling is recorded",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.amber[900],
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    child: Column(
                      children: [
                        Icon(Icons.assignment_turned_in_sharp),
                        Text('I am done!')
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            new Color(0xFFFDBC59)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))))
              ],
            )));
  }
}
