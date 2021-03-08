import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

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
    } on ApiException catch (e) {
      print('GET call failed: $e');

    }

  }
}