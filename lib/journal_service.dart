import 'dart:typed_data';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import './fetch_data.dart';

class Journal {
  //to create or edit diary
  void sendDairy(String text, String dateTime, String moodPath) async {
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
                  '\'mood\':\'$moodPath\''
                  '}'.codeUnits)
      );
      RestOperation restOperation = Amplify.API.put(
          restOptions: options
      );
      RestResponse response = await restOperation.response;
      print('PUT call sendDairy succeeded');
    } on ApiException catch (e) {
      print('PUT call sendDairy failed: $e');
    }

  }

  //to delete diary
  void deleteDairy(String dateTime) async {
    String userId = await Fetch().fetchUserId();

    try {
      RestOptions options = RestOptions(
          path: '/diaries/delete_diary',
          body:
          Uint8List.fromList(
              '{'
                  '\'id\':\'$userId\','
                  '\'sdate\':\'$dateTime\''
                  '}'.codeUnits)
      );
      RestOperation restOperation = Amplify.API.delete(
          restOptions: options
      );
      RestResponse response = await restOperation.response;
      print('DELETE call sendDairy succeeded');
    } on ApiException catch (e) {
      print('DELETE call sendDairy failed: $e');
    }

  }

  void getDiary(String dateTime) async {
    String userId = await Fetch().fetchUserId();

    try {
      RestOptions options = RestOptions(
        path: '/diaries/get_diary',
        body:
          Uint8List.fromList(
            '{'
                '\'id\':\'$userId\','
                '\'date\':\'$dateTime\''
            '}'.codeUnits)
      );
      RestOperation restOperation = Amplify.API.get(restOptions: options);
      RestResponse response = await restOperation.response;
    } on ApiException catch (err) {
      print('Error: failed to retrieve diary: $err');
    }
  }

  void getDiaries() async {
    String userId = await Fetch().fetchUserId();

    try {
      RestOptions options = RestOptions(
        path: '/diaries/get_diaries',
        body:
          Uint8List.fromList(
            '{'
                '\'id\':\'$userId\''
            '}'.codeUnits)
          );
      RestOperation restOp = Amplify.API.get(restOptions: options);
      RestResponse response = await restOp.response;
    } on ApiException catch (err) {
      print('Error: failed to retrieve user diaries: $err');
    }
  }
}
