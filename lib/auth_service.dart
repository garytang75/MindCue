import 'dart:async';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import './auth_credentials.dart';

// state enumeration
enum AuthFlowStatus { login, signUp, verification, session }

class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({this.authFlowStatus});
}

// manages the stream controller of AuthState and contains all of our authentication functionality
class AuthService {
  // responsible for sending new AuthState's down stream to be observed
  final authStateController = StreamController<AuthState>();
  //property used to keep the SignUpCredentials in memory during the sign up process
  // so a user can be logged in immediately after verifying their email address.
  AuthCredentials _credentials;
  // function to update the AuthState stream to signUp
  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signUp);
    authStateController.add(state);
  }

  // updates the stream to send login
  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }

  // user passes any AuthCredentials we will perform some logic and ultimately put
  // the user in a session state
  void loginWithCredentials(AuthCredentials credentials) async {
    try {
      // passing the AuthCredentials username and password to the Amplify sign in method and awaiting the result.
      final result = await Amplify.Auth.signIn(
          username: credentials.username, password: credentials.password);

      // if sign in is successful we update the state to session.
      if (result.isSignedIn) {
        final state = AuthState(authFlowStatus: AuthFlowStatus.session);
        authStateController.add(state);
        Fluttertoast.showToast(
          msg: "Sign in sucessfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 12.0,
        );
      } else {
        //If the user enters in the wrong credentials or gets any other error
        print('User could not be signed in');
      }
    } on AuthException catch (authError) {
      print('Could not login - ${authError}');
      //On exception, create a toast to notify user that they can't log in.
      Fluttertoast.showToast(
        msg: "Could not login, there is an issue with your username or password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 12.0,
      );
    }
  }

  void showHome() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.session);
    authStateController.add(state);
  }

  void signUpWithCredentials(SignUpCredentials credentials) async {
    try {
      // userAttributes needs to be passed in the user's email as part of the sign up.
      final userAttributes = {'email': credentials.email, 'nickname': credentials.nickname };

      // we pass in the username and password, along with the userAttributes containing
      // the email to sign up with Cognito
      final result = await Amplify.Auth.signUp(
          username: credentials.username,
          password: credentials.password,
          options: CognitoSignUpOptions(userAttributes: userAttributes));
      // store the SignUpCredentials in _credentials for when the user verifies their email
      this._credentials = credentials;

      // update the AuthState to verification just as we did before, but only
      // after successfully signing in and establishing that the sign up process is not complete.
      final state = AuthState(authFlowStatus: AuthFlowStatus.verification);
      authStateController.add(state);
      // }

      // If the sign up fails for any reason, we will simply print out the error to the logs.
    } on AmplifyException catch (authError) {
      print('Failed to sign up - ${authError.message}');
    }
  }

  // handle the verification code and update the state to session
  void verifyCode(String verificationCode) async {
    try {
      // use _credentials to supply the username and pass the code entered from VerificationPage to confirmSignUp
      final result = await Amplify.Auth.confirmSignUp(
          username: _credentials.username, confirmationCode: verificationCode);

      // If the sign up is complete, we login the user with _credentials.
      if (result.isSignUpComplete) {
        loginWithCredentials(_credentials);
      } else {
        // sign up in not complete
        print('sign up is not complete');
      }
      final state = AuthState(authFlowStatus: AuthFlowStatus.session);
      authStateController.add(state);
    } on AuthException catch (authError) {
      print('Could not verify code - ${authError.message}');
    }
  }

  void logOut() async {
    try {
      // call Auth.signOut() without passing in any options, we sign out only the user on this device
      await Amplify.Auth.signOut();

      // reuse our showLogin() method to update the state and take the user back to the
      // login screen once the sign out is successful.
      showLogin();
    } on AuthException catch (authError) {
      print('Could not log out - ${authError.message}');
    }
  }

  //automatically log the user in if they close the app but have already logged in during a previous session.
  void checkAuthStatus() async {
    try {
      await Amplify.Auth.fetchAuthSession();

      final state = AuthState(authFlowStatus: AuthFlowStatus.session);
      authStateController.add(state);
    } catch (_) {
      final state = AuthState(authFlowStatus: AuthFlowStatus.login);
      authStateController.add(state);
    }
  }
}
