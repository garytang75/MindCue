import 'dart:typed_data';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

import './fetch_data.dart';

class Journal {

  void sendDairy(String text, String dateTime) async {
    String userId = await Fetch().fetchUserId();
    print(dateTime);
    try {
      RestOptions options = RestOptions(
          path: '/diaries/put_diary',
          body:
          Uint8List.fromList(
              '{'
                  '\'id\':\'$userId\','
                  '\'date\':\'$dateTime\','
                  '\'text\':\'$text\','
                  '\'mood\':\'$text\','
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

  void deleteDairy(String date) async {
    String userId = await Fetch().fetchUserId();

    try {
      RestOptions options = RestOptions(
          path: '/diaries/delete_diary',
          body:
          Uint8List.fromList(
              '{'
                  '\'id\':\'$userId\','
                  '\'date\':\'\','
                  '\'time\':\'\''
                  '}'.codeUnits)
      );
      RestOperation restOperation = Amplify.API.delete(
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

  void editDairy(String text, String date) async {
    String userId = await Fetch().fetchUserId();

    try {
      RestOptions options = RestOptions(
          path: '/diaries/delete_diary',
          body:
          Uint8List.fromList(
              '{'
                  '\'id\':\'$userId\','
                  '\'date\':\'\','
                  '\'time\':\'\''
                  '}'.codeUnits)
      );
      RestOperation restOperation = Amplify.API.delete(
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