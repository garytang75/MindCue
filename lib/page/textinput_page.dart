import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_auth2/widgets/mood_icons.dart';

import '../fetch_data.dart';
import '../journal_service.dart';


class TextInput extends StatefulWidget {
  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  TextEditingController _journalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Text me', style: TextStyle(color: Colors.grey[850]),),
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => popupMoodIcons(context),
                    );
                    // Journal().sendDairy(_journalController.text);
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
                        backgroundColor: MaterialStateProperty.all<Color>(new Color(0xFFFDBC59)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                        )
                    )
                )
              ],
            )));
  }
}
