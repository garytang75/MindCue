import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../audio_service.dart';
import '../widgets/audio_list.dart';
import '../widgets/audio_recorder.dart';

class RecorderHomeView extends StatefulWidget {
  @override
  RecorderHomeViewState createState() => RecorderHomeViewState();
}

class RecorderHomeViewState extends State<RecorderHomeView> {
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
        while(records.length > 6){
          records.removeLast();
        }

        // records = records.reversed.toList();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Journal",
            style: TextStyle(
                color: Colors.black)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: RecordListView(
              records: records,
            ),
          ),
          Expanded(
            flex: 1,
            child: RecorderView(
              onSaved: _onRecordComplete,
            ),
          ),
        ],
      ),
    );
  }

  //when recording is completed
  _onRecordComplete() {
    records.clear();
    appDirectory.list().listen((onData) {
      records.add(onData.path);
      path = onData.path;
    }).onDone(() {
      records.sort();
      // records = records.reversed.toList();
      while(records.length > 6){
        records.removeLast();
      }
      setState(() {});
      print(path);
      Journal().uploadFile(path);
    });

  }

  //delete file locally
  void deleteLocaly({@required String file}) {
    Directory appDirec = Directory(file);
    appDirec.delete(recursive: true);
    print(appDirec);
      }

}