import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class Fetch {
  void testGetRequest() async {

    try {
      RestOptions options = RestOptions(
          path: '/test'
      );
      RestOperation restOperation = Amplify.API.get(
          restOptions: options
      );
      RestResponse response = await restOperation.response;
      print('GET call succeeded');
      // print(response);
      print(new String.fromCharCodes(response.data));
    } on ApiException catch (e) {
      print('GET call failed: $e');

    }

  }
  // void fetchSession() async {
  //   try {
  //     CognitoAuthSession res = await Amplify.Auth.fetchAuthSession(
  //         options: CognitoSessionOptions(getAWSCredentials: true)
  //     );
  //     print('idToken: ' + res.userPoolTokens.idToken.toString());
  //     print('accessToken: ' + res.userPoolTokens.accessToken.toString());
  //   } on AuthException catch (e) {
  //     print(e.message);
  //   }
  // }
}