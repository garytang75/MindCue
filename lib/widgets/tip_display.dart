import 'package:flutter/material.dart';
import 'package:flutter_auth2/page/questionnaires_page.dart';

class TipDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.3),
      child: new Container(
        height: 300,
        width: 350,
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(2),
        child: Row(
          children: <Widget>[
            Flexible(
                // height: 320,
                child: FutureBuilder<String>(
              future: QuestionnairesState().sendResult(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tip to boost your mental health:",
                          style: TextStyle(
                              fontSize: 20,
                              height: 1.5,
                              color: Color(0xFFe3a600),
                              fontWeight: FontWeight.bold)),
                      Text("Based on your quiz result",
                          style: TextStyle(
                              fontSize: 14, height: 1, color: Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                        child: Text(snapshot.data,
                            style: TextStyle(fontSize: 16, height: 1.6)),
                      )
                    ],
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Want some advice?", style: TextStyle(fontSize: 18)),
                    Text("Take a quiz!",
                        style: TextStyle(
                            fontSize: 20,
                            height: 2,
                            color: Color(0xFFe3a600),
                            fontWeight: FontWeight.bold))
                  ],
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
