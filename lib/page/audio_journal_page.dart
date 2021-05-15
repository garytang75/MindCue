import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_auth2/widgets/circular_button.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/audio_list.dart';

class AudioJournal extends StatefulWidget {
  @override
  AudioJournalState createState() => AudioJournalState();
}

class AudioJournalState extends State<AudioJournal> {
  Directory appDirectory;
  Stream<FileSystemEntity> fileStream;
  List<String> records;
  String path;

  @override
  void initState() {
    super.initState();
    records = [];
    getApplicationDocumentsDirectory().then((value) {
      appDirectory = value;
      appDirectory.list().listen((onData) {
        records.add(onData.path);
      }).onDone(() {
        records = records.reversed.toList();
        setState(() {});
      });
    });
  }

  // reset all values
  @override
  void dispose() {
    fileStream = null;
    appDirectory = null;
    records = null;
    super.dispose();
  }

///TODO make records list scrollable
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        title: Text("Audio Journal",
            style: TextStyle(
                color: Colors.black)),
      ),
      body: Stack(
        children: [
          Expanded(
            // flex: 2,
            child: RecordListView(
              records: records,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFFCEE2EE), shape: BoxShape.rectangle),
              height: 55,
            ),
          ),
          Align(
            alignment: Alignment(0, 0.92),
            child: CircularButton(
                color: Color(0xFFFDBC59),
                width: 60,
                height: 60,
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                  color: Colors.black,
                ),
                onClick: () {
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );

  }

  //delete file locally
  void deleteLocaly({@required String file}) {
    Directory appDirec = Directory(file);
    appDirec.delete(recursive: true);
    print(appDirec);
  }

}