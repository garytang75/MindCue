import 'package:flutter/material.dart';
import 'package:flutter_auth2/models/journal.dart';

/*
3/28/2021 Gary- Moved the List of the Journal into Journal Page
*/
class JournalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal Page'),
      ),
      body: ListView(
        children: [
          Column(
            children: journals.map((jr) {
              return Card(
                  child: Row(
                children: [
                  Column(children: [
                    Text(jr.userId),
                    SizedBox(
                      width: 300,
                      height: 150,
                      child: Text(
                        jr.journals,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(jr.createdAt.toString()),
                  ]),
                  Icon(Icons.sentiment_dissatisfied, color: Colors.red),
                ],
              ));
            }).toList(),
          ),
        ],
      ),
    );
  }
}
