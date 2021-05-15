import 'dart:typed_data';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import './fetch_data.dart';

class AccountDeletion {
  void deleteUser() async {
    final String user = await Fetch().fetchUserId();
    try {
      RestOptions options = RestOptions(
          path: '/delete_account/delete_account',
          body:
          Uint8List.fromList(
              '{'
                  '\'id\':\'$user\''
                  '}'.codeUnits)
      );
      RestOperation restOp = Amplify.API.put(restOptions: options);
      RestResponse response = await restOp.response;
      print('PUT call sendDairy succeeded');
    } on ApiException catch (err) {
      print('Could not delete account: $err');
    }
  }
}