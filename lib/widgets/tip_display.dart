import 'package:flutter/material.dart';
import 'package:flutter_auth2/page/questionnaires_page.dart';

class TipDisplay extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        child: Row(
          children: <Widget>[
            FutureBuilder<String>(
              future: QuestionnairesState().sendResult(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Text(snapshot.data);
                }
                return Text("no tips yet");
              },
            )
          ],
        ),
      ),
    );
  }
}
