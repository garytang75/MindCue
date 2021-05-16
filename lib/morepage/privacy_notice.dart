import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PrivacyNotice extends StatelessWidget {
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
            Text("Privacy Policy of MindCue",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Text(
                "Please take a moment to familiarize yourself with our Privacy Policy and let us know if you have any questions.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15)),
            SizedBox(height: 20),
            Text("I. Introduction",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "This Privacy Policy (\"Privacy Policy\") describes the privacy practices that we, MindCue, employ with regard to collecting, using and disclosing information, both personal and non-personal information, which we receive when you use our Services. By using the Services you consent to the practices described in this Privacy Policy."),
            SizedBox(height: 20),
            Text("II. How We Collect Info",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "We Do Not Collect Personal Information. Personal Information includes your address, telephone number, fax number, geographical location."),
            SizedBox(height: 20),
            Text("III. Non-Personal Information",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "We may collect other information that cannot be used to identify a specific individual (that is, information that is not personal information), for example statistical data generated when you use a specific service, such as user activity (including clicks, page redirects, and browsing time). This information is collected in order to improve the services we provide to you. We are committed to safeguarding any information collected through the Services. "),
            SizedBox(height: 20),
            Text("IV. Contact Us",
                style: TextStyle(
                    color: Color(0xFFe3a600),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                "If you have any questions or feedback regarding this Privacy Policy, or if you have any questions regarding how we collect, use your information, please contact us by emailing mindcue@gmail.com and mention that your message is in reference to the “Privacy Policy”. Our response team will be able to handle any issues you may have about rights requests or questions about your information. If you have a particularly critical issue that needs to be addressed, we may ask you to provide us with more information. If you are not satisfied with the response you receive, you may escalate your complaint to the applicable regulatory authority in your jurisdiction. Upon request, we will provide you with information on how to file a complaint based on your actual circumstances."),
          ],
        ),
      ),
    );
  }
}
