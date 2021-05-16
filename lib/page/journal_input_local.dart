import 'package:flutter/material.dart';
import 'package:flutter_auth2/models/journallocal.dart';
import 'package:flutter_auth2/widgets/mood_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../journal_service.dart';
import 'journal_page.dart';

class JournalInputLocal extends StatefulWidget {
  final JournalLocal item;

  JournalInputLocal({this.item});

  @override
  _JournalInputLocalState createState() => _JournalInputLocalState();
}

class _JournalInputLocalState extends State<JournalInputLocal> {
  TextEditingController mytextController;

  moodIconAlert(BuildContext context) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return popupMoodIcons(context);
      },
    );
  }

  void initState() {
    super.initState();
    mytextController = new TextEditingController(
        text: widget.item != null ? widget.item.journals : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item != null ? 'Edit Journal' : 'New Journal',
          key: Key('new-item-title'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              maxLines: null,
              controller: mytextController,
              autofocus: true,
              // onSubmitted: (value) => submitFunction(),
              decoration: InputDecoration(labelText: 'Talk to me'),
            ),
            SizedBox(
              height: 14.0,
            ),
            ElevatedButton(
                child: const Text('Save'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(new Color(0xFFFDBC59)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  widget.item != null ? edit() : submitFunction();
                  Fluttertoast.showToast(
                      msg: "Your feeling is recorded",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.amber[900],
                      textColor: Colors.white,
                      fontSize: 16.0);
                })
          ],
        ),
      ),
    );
  }

  void submit() async {
    await moodIconAlert(context);
    String time = DateFormat.yMd().add_jm().format(DateTime.now());
    Navigator.of(context).pop(JournalLocal(
        journals: mytextController.text, createdAt: time, iconPath: path));
  }

  void edit() {
    String time = DateTime.now().toString();
    Navigator.of(context).pop(JournalLocal(
        journals: mytextController.text, createdAt: time, iconPath: path));
  }

  void submitFunction() async {
    await moodIconAlert(context);
    String time = DateFormat.yMd().add_jm().format(DateTime.now());
    Journal().sendDairy(mytextController.text, time, path);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JournalPage(
              recieve: JournalLocal(
                  createdAt: time,
                  iconPath: path,
                  journals: mytextController.text)),
        ));
    textJournal().sendDairy(mytextController.text, time, path);
  }
}
