import 'package:flutter/material.dart';
import 'package:flutter_auth2/page/audio_journal_page.dart';
import 'package:flutter_auth2/page/journal_page.dart';
import 'package:flutter_auth2/page/user_pprofile_page.dart';
import 'package:flutter_auth2/page/stats_page.dart';
import '../fetch_data.dart';
import 'circular_button.dart';

class BottomApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  iconSize: 30,
                  icon: ImageIcon(AssetImage('assets/icon/book.png')),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JournalPage()),
                    );
                  },
                ),
                Text(
                  'text journal',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     IconButton(
            //       icon: ImageIcon(AssetImage('assets/icon/bars.png')),
            //       onPressed: () {
            //         print('2');
            //       },
            //     ),
            //     Text(
            //       'stats',
            //       style: TextStyle(fontSize: 10),
            //     )
            //   ],
            // ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: ImageIcon(AssetImage('assets/icon/playlist.png')),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AudioJournal()),
                    );
                  },
                ),
                Text(
                  'audio journal',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  iconSize: 20,
                  icon: ImageIcon(AssetImage('assets/icon/bars.png')),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatsPage()),
                    )
                  },
                ),
                Text(
                  'stats',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     IconButton(
            //       iconSize: 20,
            //       icon: ImageIcon(AssetImage('')),
            //       onPressed: () => {},
            //     ),
            //     Text(
            //       '',
            //       style: TextStyle(fontSize: 10),
            //     ),
            //   ],
            // ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularButton(
                  color: Colors.transparent,
                  width: 50,
                  height: 50,
                  icon: Icon(Icons.more_horiz_outlined, color: Colors.black),
                  onClick: () {
                    //get user nickname from Cognito
                    Fetch().fetchNickname().then((value) {
                      final nickname = value;
                      Navigator.push(
                        context,
                        //change page to user_profile page and pass userId
                        MaterialPageRoute(
                            builder: (context) =>
                                UserProfile(nickname: nickname)),
                      );
                    });
                  },
                ),
                Text(
                  'more',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
