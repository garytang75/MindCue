import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TermsAndCondition extends StatelessWidget {
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
            Text("Terms & Conditions",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Text("Condition Of Use",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "By using this app, you certify that you have read and reviewed this Agreement and that you agree to comply with its terms. If you do not want to be bound by the terms of this Agreement, you are advised to delete the app accordingly. MindCue only grants use and access of this application to those who have accepted its terms."),
            SizedBox(height: 20),
            Text("User Accounts",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "On this app, you will be asked to create an account. Account will not contain any sensitive informations. Any other infomations generate through the use of this application will not be used for any other purposes. Please review Privacy Policy to learn more about how we are handling your information."),
            SizedBox(height: 20),
            Text("Limitation on liability",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "MindCue is not liable for any damages that may occur to you as a result of your misuse of our application. \n MindCue reserves the right to edit, modify, and change this Agreement at any time. We shall let our users know of these changes through app notification. This Agreement is an understanding between MindCue and the user, and this supersedes and replaces all prior agreements regarding the use of this website."),
            SizedBox(height: 20),
            Text("Users/Participants",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "We do not discriminate on the basis of age, race, national origin, gender, sexual orientation or religion. MindCue is an application aim to help people who are struggling with mental health issues."),
          ],
        ),
      ),
    );
  }
}
