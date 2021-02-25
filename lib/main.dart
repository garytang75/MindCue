import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import './login_page.dart';
import './sign_up_page.dart';
import './auth_service.dart';
import './verification_page.dart';
import './home_page.dart';
import './amplifyconfiguration.dart';

void main() {
  runApp(MyApp());
}

// StatefulWidget MyApp to manipulate its state
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final _amplify = Amplify();
  bool _amplifyConfigured = false;
  final _authService = AuthService();
  @override
  void initState() {
    super.initState();
    _configureAmplify();
    // _authService.checkAuthStatus();
    _authService.showLogin();
  }

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
      print('EEEE: ');
      print(e);
    }

  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindCue App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: StreamBuilder<AuthState>(
          stream: _authService.authStateController.stream,
          builder: (context, snapshot) {
            // If the stream has data
            if (snapshot.hasData) {
              return Navigator(
                pages: [
                  // Show Login Page
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                    MaterialPage(
                        child: LoginPage(
                            didProvideCredentials: _authService.loginWithCredentials,
                            shouldShowSignUp: _authService.showSignUp)),

                  // Show Sign Up Page
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                    MaterialPage(
                        child: SignUpPage(
                            didProvideCredentials: _authService.signUpWithCredentials,
                            shouldShowLogin: _authService.showLogin)),

                  // Show Verification Code Page
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                    MaterialPage(child: VerificationPage(
                        didProvideVerificationCode: _authService.verifyCode)),

                  if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                    MaterialPage(
                        child: HelloWorld(shouldLogOut: _authService.logOut))

                ],
                onPopPage: (route, result) => route.didPop(result),
              );
            } else {
              // If the stream doesn't have data, a CircularProgressIndicator is displayed.
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),

              );
            }
          }),

    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:amplify_flutter/amplify.dart';
// import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'amplifyconfiguration.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   bool _amplifyConfigured = false;
// //
//   // Instantiate Amplify
//   //Amplify amplifyInstance = Amplify();
//
//   // controllers for text input
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   bool isSignUpComplete = false;
//   bool isSignedIn = false;
// //
//   @override
//   void initState() {
//     super.initState();
//     _configureAmplify();
//   }
//   //
//   @override
//   void dispose() {
//     // Clean up the controller when the widget is removed from the
//     // widget tree.
//     emailController.dispose();
//     passwordController.dispose();
//
//     super.dispose();
//   }
//   //
//   void _configureAmplify() async {
//     if (!mounted) return;
//
//     // Add Pinpoint and Cognito Plugins
//     Amplify.addPlugin(AmplifyAnalyticsPinpoint());
//     Amplify.addPlugin(AmplifyAuthCognito());
//
//
//     // Once Plugins are added, configure Amplify
//     // Note: Amplify can only be configured once.
//     try {
//       await Amplify.configure(amplifyconfig);
//     } on AmplifyAlreadyConfiguredException {
//       print("Amplify was already configured. Was the app restarted?");
//     }
//     try {
//       setState(() {
//         _amplifyConfigured = true;
//       });
//     } catch (e) {
//       print(e);
//     }
//
//   }
//
//   // Send an event to Pinpoint
//   void _recordEvent() async {
//     AnalyticsEvent event = AnalyticsEvent('test');
//     event.properties.addBoolProperty('boolKey', true);
//     event.properties.addDoubleProperty('doubleKey', 10.0);
//     event.properties.addIntProperty('intKey', 10);
//     event.properties.addStringProperty('stringKey', 'stringValue');
//     Amplify.Analytics.recordEvent(event: event);
//   }
//
//   Future<String> _registerUser(LoginData data) async {
//     try {
//       Map<String, String> userAttributes = {
//         "email": emailController.text,
//       };
//       SignUpResult res = await Amplify.Auth.signUp(
//           username: data.name,
//           password: data.password,
//           options: CognitoSignUpOptions(userAttributes: userAttributes)
//       );
//       setState(() {
//         isSignUpComplete = res.isSignUpComplete;
//         if (!isSignUpComplete) {
//             // needs email confirmation
//             print("Not yet Complete, needs email confirmation");
//
//           } else {
//             // signup was ok. do login
//             print("Complete");
//           }
//         // print("Sign up: " + (isSignUpComplete ? "Complete" : "Not Complete"));
//         // print(isSignUpComplete);
//       });
//     } on AuthException catch (e) {
//       print(e);
//       return "Register Error: " + e.toString();
//     }
// //confirm signup
//     try {
//       print('test');
//       SignUpResult res = await Amplify.Auth.confirmSignUp(
//           username: data.name,
//           confirmationCode: '12345'
//       );
//       setState(() {
//         isSignUpComplete = res.isSignUpComplete;
//
//         // print("Sign up: " + (isSignUpComplete ? "Complete" : "Not Complete"));
//         // print(isSignUpComplete);
//       });
//     } on AuthException catch (e) {
//       print(e.message);
//     }
//
//   }
//
//   Future<String> _signIn(LoginData data) async {
//     try {
//       SignInResult res = await Amplify.Auth.signIn(
//         username: data.name,
//         password: data.password,
//       );
//       setState(() {
//         isSignedIn = res.isSignedIn;
//       });
//
//       if (isSignedIn)
//         // Alert(context: context, type: AlertType.success, title: "Login Success")
//         //     .show();
//         return 'Logged in!';
//     } on AuthException catch (e) {
//       print(e.message);
//       // Alert(context: context, type: AlertType.error, title: "Login Failed")
//       //     .show();
//       return 'Log In Error: ' + e.toString();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           body: SafeArea(
//               child: FlutterLogin(
//                   logo: "assets/logo.png",
//                   onLogin: _signIn,
//                   onSignup: _registerUser,
//                   onRecoverPassword: (_) => null,
//                   title: 'Welcome!',),
//
//             ),
//           ),
//     );
//
//   }
// }