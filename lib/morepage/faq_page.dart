import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            Container(
                height: 100,
                width: 100,
                child: Image.asset("assets/icon/logo2.png")),
            Text("FAQ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Text(
                "All your potiential questions will be answer here. If your question does not appear, please email us at mindcue@gmail.com",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 20),
            Text("If I delete my account, all data will be deleted?",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "Yes, all your data will be delete on our server, however please allow up to one week for your data to be deleted."),
            SizedBox(height: 20),
            Text("What does sentiment of last journal mean?",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "We conduct sentiment analysis on the your journal entries, as we continue to improve our app, we would like our users to recieve feed back on their journals. As of right now, you can find the sentiment analysis on your latest journal on the home page. In the future, you would be able to see all the analysis on your journal entries."),
            SizedBox(height: 20),
            Text("Do I have to choose emojis for every journal I create?",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "Emoji is a way for your to express your feeling. Of course you have the choice to have no emoji for the journal you've created. We would like you to express yourself as much as you can, so you can feel better!"),
            SizedBox(height: 20),
            Text("Is my personal data safe?",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "Yes, all your data are secured via AWS. We do not share your data without your permission. Since all your data are sensitive data, we would risk anything to protect you from getting hurt."),
          ],
        ),
      ),
    );
  }
}
