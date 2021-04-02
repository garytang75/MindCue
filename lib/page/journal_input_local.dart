import 'package:flutter/material.dart';
import 'package:flutter_auth2/models/journallocal.dart';

class JournalInputLocal extends StatefulWidget {
  final JournalLocal item;

  JournalInputLocal({this.item});

  @override
  _JournalInputLocalState createState() => _JournalInputLocalState();
}

class _JournalInputLocalState extends State<JournalInputLocal> {
  TextEditingController mytextController;

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
          widget.item != null ? 'Edit todo' : 'New todo',
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
              controller: mytextController,
              autofocus: true,
              onSubmitted: (value) => submit(),
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(
              height: 14.0,
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Save',
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.title.color),
              ),
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              onPressed: () => submit(),
            )
          ],
        ),
      ),
    );
  }

  void submit() {
    String time = DateTime.now().toString();
    Navigator.of(context)
        .pop(JournalLocal(journals: mytextController.text, createdAt: time));
  }
}
