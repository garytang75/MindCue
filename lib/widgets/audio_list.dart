import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth2/page/audio_input_page.dart';

class RecordListView extends StatefulWidget {
  final Function deleteLocaly;
  final List<String> records;
  const RecordListView({
    Key key,
    this.records, this.deleteLocaly,
  }) : super(key: key);

  @override
  _RecordListViewState createState() => _RecordListViewState();
}

class _RecordListViewState extends State<RecordListView> {
  AudioPlayer audioPlayer = AudioPlayer();
  int _totalDuration;
  int _currentDuration;
  double _completedPercentage = 0.0;
  bool _isPlaying = false;
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.records.length,
      // shrinkWrap: true,
      // reverse: true,
      itemBuilder: (BuildContext context, int i) {
        return
        ExpansionTile(
          title: Text('Recoding ${widget.records.length - i}'),
          subtitle: Text(
              _getDateFromFilePath(filePath: widget.records.elementAt(i)),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
              )
          ),
          onExpansionChanged: ((newState) {
            if (newState) {
              setState(() {
                _selectedIndex = i;
              });
            }
          }),
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearProgressIndicator(
                    minHeight: 5,
                    backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    value: _selectedIndex == i ? _completedPercentage : 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () => _onPlay(
                              filePath: widget.records.elementAt(i), index: i),
                        ),
                        IconButton(
                          icon: Icon(Icons.pause),
                          onPressed: () => _onPause(),
                        ),
                        IconButton(
                          icon: Icon(Icons.stop),
                          onPressed: () => _onStop(),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.redAccent,
                          onPressed: () => _deleteRecoriding(
                              filePath: widget.records.elementAt(i))
                        ),
                        ]
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  //play audio player
  Future<void> _onPlay({@required String filePath, @required int index}) async {
    if (!_isPlaying) {
      audioPlayer.play(filePath, isLocal: true);
      setState(() {
        _selectedIndex = index;
        _completedPercentage = 0.0;
        _isPlaying = true;
      });

      audioPlayer.onPlayerCompletion.listen((_) {
        audioPlayer.stop();
        setState(() {
          _isPlaying = false;
          _completedPercentage = 0.0;
        });
      });
      audioPlayer.onDurationChanged.listen((duration) {
        setState(() {
          _totalDuration = duration.inMicroseconds;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((duration) {
        setState(() {
          _currentDuration = duration.inMicroseconds;
          _completedPercentage =
              _currentDuration.toDouble() / _totalDuration.toDouble();
        });
      });
    }
  }

  //pause audio player
  Future<void> _onPause() async {

    if (_isPlaying) {
      audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });

    }
  }

  //stop audio player
  Future<void> _onStop({@required String filePath, @required int index}) async {
    audioPlayer.stop();
    setState(() {
      _selectedIndex = index;
      _completedPercentage = 0.0;
      _isPlaying = false;
    });


  }

  //get recording date
  String _getDateFromFilePath({@required String filePath}) {
    String fromEpoch = filePath.substring(
        filePath.lastIndexOf('/') + 1, filePath.lastIndexOf('.'));

    DateTime recordedDate =
    DateTime.fromMillisecondsSinceEpoch(int.parse(fromEpoch));
    int year = recordedDate.year;
    int month = recordedDate.month;
    int day = recordedDate.day;

    return ('$year/$month/$day');
  }

  //remove recording from list and delete locally
  Future<void> _deleteRecoriding({@required String filePath}) async {
    audioPlayer.stop();
    setState(() {
      widget.records.remove(filePath);
      _isPlaying = false;
    });
    RecorderHomeViewState().deleteLocaly(file: filePath);

  }
}