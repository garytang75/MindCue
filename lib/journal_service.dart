import 'dart:typed_data';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

import './fetch_data.dart';

class Journal {

  void sendDairy(String text) async {
    var userId = Fetch().fetchSession();
    var date = DateTime.now();
    var text = "This is a journal entry text";
    try {
      RestOptions options = RestOptions(
          path: 'diaries/put_diary',
          body:
          Uint8List.fromList(
              '{'
                  '\'id\':\'$userId\','
                  '\'date\':\'$date\','
                  '\'text\':\'$text\''
                  '}'.codeUnits)
      );
      RestOperation restOperation = Amplify.API.put(
          restOptions: options
      );
      RestResponse response = await restOperation.response;
      print('PUT call sendDairy succeeded');
      var finalres = json.decode(String.fromCharCodes(response.data));
      print(new String.fromCharCodes(response.data));

      print(finalres['input']);
    } on ApiException catch (e) {
      print('PUT call sendDairy failed: $e');
    }

  }

}