import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
          title: Text('Text me'),
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
                    Journal().sendDairy(_journalController.text);
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
                )
              ],
            )));
  }
}
