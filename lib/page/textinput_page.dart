import 'package:flutter/material.dart';

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
                    print(_journalController.text);
                    _journalController.text = "";
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
