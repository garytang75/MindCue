import 'dart:typed_data';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import './fetch_data.dart';

class AccountDeletion {
  void deleteUser() async {
    final String user = await Fetch().fetchUserId();
    try {
      RestOptions options = RestOptions(
          path: '/account/delete',
          body:
          Uint8List.fromList(
              '{'
                  '\'id\':\'$user\''
              '}'.codeUnits)
      );
      RestOperation restOp = Amplify.API.put(restOptions: options);
      RestResponse response = await restOp.response;
    } on ApiException catch (err) {
      print('Could not delete account: $err');
    }
  }
}