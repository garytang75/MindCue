import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'circular_button.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class RecorderView extends StatefulWidget {
  final Function onSaved;

  const RecorderView({Key key, @required this.onSaved}) : super(key: key);
  @override
  _RecorderViewState createState() => _RecorderViewState();
}

enum RecordingState {
  UnSet,
  Set,
  Recording,
  Stopped,
}

class _RecorderViewState extends State<RecorderView> {
  IconData _recordIcon = Icons.mic_none;
  String _recordText = 'Click To Start';
  RecordingState _recordingState = RecordingState.UnSet;

  // Recorder properties
  FlutterAudioRecorder audioRecorder;

  @override
  void initState() {
    super.initState();

    FlutterAudioRecorder.hasPermissions.then((hasPermision) {
      if (hasPermision) {
        _recordingState = RecordingState.Set;
        _recordIcon = Icons.mic;
        _recordText = 'Press button to start recording';
      }
    });
  }

  @override
  void dispose() {
    _recordingState = RecordingState.UnSet;
    audioRecorder = null;
    super.dispose();
  }

  //timer
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(); // Create instance.

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularButton(
          color: Color(0xFFFDBC59),
          width: 70,
          height: 70,
          icon: Icon(
            _recordIcon,
            size: 30,
            color: Colors.black,
          ),
          onClick: () async {
            await _onRecordButtonPressed();
            setState(() {});

          }
        ),
        StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          initialData: 0,
          builder: (context, snap) {
            final value = snap.data;
            final displayTime = StopWatchTimer.getDisplayTime(value);
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(60),
                  child: Text(
                    displayTime,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                ],
            );
          },
        ),

        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              child: Text(_recordText,
                style: TextStyle(
                    fontSize: 18,

                ),),
              padding: const EdgeInsets.all(45),
            ))
      ],
    );
  }

  Future<void> _onRecordButtonPressed() async {
    switch (_recordingState) {
      case RecordingState.Set:
        await _recordVoice();
        break;

      case RecordingState.Recording:
        await _stopRecording();
        _recordingState = RecordingState.Stopped;
        _recordIcon = Icons.mic;
        _recordText = 'Record new one';
        break;

      case RecordingState.Stopped:
        await _recordVoice();
        break;

      case RecordingState.UnSet:
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Please allow recording from settings.'),
        ));
        break;
    }
  }

  _initRecorder() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String filePath = appDirectory.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';

    audioRecorder =
        FlutterAudioRecorder(filePath, audioFormat: AudioFormat.AAC);
    await audioRecorder.initialized;
  }

  _startRecording() async {
    await audioRecorder.start();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start); //start timer
  }

  _stopRecording() async {
    await audioRecorder.stop();
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset); // Reset timer
    widget.onSaved();
  }


  Future<void> _recordVoice() async {
    if (await FlutterAudioRecorder.hasPermissions) {
      await _initRecorder();

      await _startRecording();
      _recordingState = RecordingState.Recording;
      _recordIcon = Icons.stop;
      _recordText = 'Recording in progress';
    } else {
      // Fluttertoast.showToast(
      //   msg: "Please allow recording in settings",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   fontSize: 12.0,
      // );
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please allow recording from settings.'),
      ));
    }
  }
}