import 'dart:convert';
import 'dart:typed_data';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import './fetch_data.dart';

class textJournal {
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
    //send diary for sentiment analysis and database
    try {
      RestOptions options = RestOptions(
          path: '/sentiment/put',
          body:
          Uint8List.fromList(
              '{'
                  '\'UserId\':\'$userId\','
                  '\'date\':\'$dateTime\','
                  '\'Journal\':\'$text\''
                  '}'.codeUnits)
      );
      RestOperation restOperation = Amplify.API.post(
          restOptions: options
      );
      RestResponse response = await restOperation.response;
      print('PUT call send to sentiment analysis succeeded');
    } on ApiException catch (e) {
      print('PUT call send to sentiment analysis failed: $e');
    }
  }

  //get sentiment of the last journal
  Future<String> getSentiment() async{
    var finalres;
    String userId = await Fetch().fetchUserId();
    try {
      RestOptions options = RestOptions(
          path: '/sentiment/get',
          body:
          Uint8List.fromList(
              '{'
                  '\'UserId\':\'$userId\''
                  '}'.codeUnits)
      );
      RestOperation restOperation = Amplify.API.post(
          restOptions: options
      );
      RestResponse response = await restOperation.response;
      finalres = json.decode(String.fromCharCodes(response.data));

      print('POST call getSentiment succeeded');
    } on ApiException catch (e) {
      print('POST call getSentiment failed: $e');
    }
    return finalres["Sentiment"];
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
