import 'dart:typed_data';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class Fetch {
  void testGetRequest() async {
    try {
      RestOptions options = RestOptions(
          path: '/get_user'
      );
      RestOperation restOperation = Amplify.API.get(
          restOptions: options
      );
      RestResponse response = await restOperation.response;
      print('GET call succeeded');
      print(response);
      print(new String.fromCharCodes(response.data));
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }
  void testPostRequest() async {
    var user = "Max";

    try {
      RestOptions options = RestOptions(
          path: '/add_user',
          body:
          Uint8List.fromList(
              '{'
                  '\'text\':\'My first journal entry!\','
                  '\'$user\':\'asdfgfre\''
              '}'.codeUnits)
      );
      RestOperation restOperation = Amplify.API.post(
          restOptions: options
      );
      RestResponse response = await restOperation.response;
      print('POST call succeeded');
      var finalres = json.decode(String.fromCharCodes(response.data));
      print(new String.fromCharCodes(response.data));

      print(finalres['input']);
    } on ApiException catch (e) {
      print('POST call failed: $e');
    }

  }
  // print tokens
  void fetchSession() async {
    try {
      CognitoAuthSession res = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true)
      );
      print('idToken: ' + res.userPoolTokens.idToken.toString());
      print('accessToken: ' + res.userPoolTokens.accessToken.toString());
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}