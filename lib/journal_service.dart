import 'dart:typed_data';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

import './fetch_data.dart';

class Journal {

  void sendDairy(String text) async {
    String userId = await Fetch().fetchUserId();
    //get date
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM-dd-yyyy');
    final String formatted = formatter.format(now);

    try {
      RestOptions options = RestOptions(
          path: '/diaries/put_diary',
          body:
          Uint8List.fromList(
              '{'
                  '\'id\':\'$userId\','
                  '\'date\':\'$formatted\','
                  '\'text\':\'$text\''
                  '}'.codeUnits)
      );
      RestOperation restOperation = Amplify.API.put(
          restOptions: options
      );
      RestResponse response = await restOperation.response;
      print('PUT call sendDairy succeeded');
      // var finalres = json.decode(String.fromCharCodes(response.data));
      // print(new String.fromCharCodes(response.data));

      // print(finalres['input']);
    } on ApiException catch (e) {
      print('PUT call sendDairy failed: $e');
    }

  }

}