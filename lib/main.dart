import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;
//
  // Instantiate Amplify
  //Amplify amplifyInstance = Amplify();

  // controllers for text input
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isSignUpComplete = false;
  bool isSignedIn = false;
//
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }
  //
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  //
  void _configureAmplify() async {
    if (!mounted) return;

    // Add Pinpoint and Cognito Plugins
    Amplify.addPlugin(AmplifyAnalyticsPinpoint());
    Amplify.addPlugin(AmplifyAuthCognito());


    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print("Amplify was already configured. Was the app restarted?");
    }
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }

  }

  // Send an event to Pinpoint
  void _recordEvent() async {
    AnalyticsEvent event = AnalyticsEvent('test');
    event.properties.addBoolProperty('boolKey', true);
    event.properties.addDoubleProperty('doubleKey', 10.0);
    event.properties.addIntProperty('intKey', 10);
    event.properties.addStringProperty('stringKey', 'stringValue');
    Amplify.Analytics.recordEvent(event: event);
  }

  Future<String> _registerUser(LoginData data) async {
    try {
      Map<String, String> userAttributes = {
        "email": emailController.text,
      };
      SignUpResult res = await Amplify.Auth.signUp(
          username: data.name,
          password: data.password,
          options: CognitoSignUpOptions(userAttributes: userAttributes)
      );
      setState(() {
        isSignUpComplete = res.isSignUpComplete;
        if (!isSignUpComplete) {
            // needs email confirmation
            print("Not yet Complete, needs email confirmation");

          } else {
            // signup was ok. do login
            print("Complete");
          }
        // print("Sign up: " + (isSignUpComplete ? "Complete" : "Not Complete"));
        // print(isSignUpComplete);
      });
    } on AuthException catch (e) {
      print(e);
      return "Register Error: " + e.toString();
    }
//confirm signup
    try {
      print('test');
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: data.name,
          confirmationCode: '12345'
      );
      setState(() {
        isSignUpComplete = res.isSignUpComplete;

        // print("Sign up: " + (isSignUpComplete ? "Complete" : "Not Complete"));
        // print(isSignUpComplete);
      });
    } on AuthException catch (e) {
      print(e.message);
    }

  }

  Future<String> _signIn(LoginData data) async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: data.name,
        password: data.password,
      );
      setState(() {
        isSignedIn = res.isSignedIn;
      });

      if (isSignedIn)
        // Alert(context: context, type: AlertType.success, title: "Login Success")
        //     .show();
        return 'Logged in!';
    } on AuthException catch (e) {
      print(e.message);
      // Alert(context: context, type: AlertType.error, title: "Login Failed")
      //     .show();
      return 'Log In Error: ' + e.toString();
    }
  }

  @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       home: Scaffold(
  //           appBar: AppBar(
  //             title: const Text('Amplify Core example app'),
  //           ),
  //           body: ListView(padding: EdgeInsets.all(10.0), children: <Widget>[
  //             Center(
  //               child: Column (
  //                   children: [
  //                     const Padding(padding: EdgeInsets.all(5.0)),
  //                     Text(
  //                         _amplifyConfigured ? 'configured' : 'not configured'
  //                     ),
  //                     ElevatedButton(
  //                         onPressed: _amplifyConfigured ? _recordEvent : null,
  //                         child: const Text('record event')
  //                     )
  //                   ]
  //               ),
  //             )
  //           ])
  //       )
  //   );


  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
              child: FlutterLogin(
                  logo: "assets/logo.png",
                  onLogin: _signIn,
                  onSignup: _registerUser,
                  onRecoverPassword: (_) => null,
                  title: 'Welcome!',),

            ),
          ),
    );

  }
}