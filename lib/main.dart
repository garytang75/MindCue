import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';
// import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
// import 'package:amplify_api_example/rest_api_view.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'page/login_page.dart';
import 'page/sign_up_page.dart';
import './auth_service.dart';
import 'page/verification_page.dart';
import 'page/home_page.dart';
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
  bool _amplifyConfigured = false;

  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    isSignedInStatus();
  }

  isSignedInStatus() async {
    bool isSignedIn = await _isSignedIn();
    if (!isSignedIn) {
      _authService.showLogin();
    } else {
      _authService.showHome();
    }
  }

  Future<bool> _isSignedIn() async {
    final session = await Amplify.Auth.fetchAuthSession();
    // print(session.isSignedIn);
    if (session.isSignedIn) {
      return true;
    } else {
      return false;
    }
  }

  void _configureAmplify() async {
    if (!mounted) return;

    // Add Pinpoint and Cognito Plugins
    // Amplify.addPlugin(AmplifyAnalyticsPinpoint());
    Amplify.addPlugin(AmplifyAuthCognito());
    Amplify.addPlugin(AmplifyAPI());

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

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindCue App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: StreamBuilder<AuthState>(
          stream: _authService.authStateController.stream,
          builder: (context, snapshot) {
            // If the stream has data
            if (snapshot.hasData) {
              // print("AuthFlowStatus.session: ");
              // print(AuthService.checkAuthStatus());
              return Navigator(
                pages: [
                  // if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                  //   MaterialPage(
                  //       child: HomePage(shouldLogOut: _authService.logOut))
                  // Show Login Page
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                    MaterialPage(
                        child: LoginPage(
                            didProvideCredentials:
                                _authService.loginWithCredentials,
                            shouldShowSignUp: _authService.showSignUp)),

                  // Show Sign Up Page
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                    MaterialPage(
                        child: SignUpPage(
                            didProvideCredentials:
                                _authService.signUpWithCredentials,
                            shouldShowLogin: _authService.showLogin)),

                  // Show Verification Code Page
                  if (snapshot.data.authFlowStatus ==
                      AuthFlowStatus.verification)
                    MaterialPage(
                        child: VerificationPage(
                            didProvideVerificationCode:
                                _authService.verifyCode)),

                  if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                    MaterialPage(
                        child: HomePage(shouldLogOut: _authService.logOut))
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
