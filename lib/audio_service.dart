import 'dart:convert';
import 'dart:typed_data';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
// import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import './fetch_data.dart';
import 'dart:io';

class Journal {
  //get signed url from s3 and send audio file to s3
  void uploadFile(path) async {
    try {
      RestOptions options = RestOptions(
          path: '/audio/get_url'
          // apiName:
      );
      RestOperation restOperation = Amplify.API.get(
          restOptions: options
      );
      RestResponse response = await restOperation.response;
      var finalres = json.decode(String.fromCharCodes(response.data));
      var url = finalres['url'];
      print(url);
      print('GET call getSignedUrl succeeded');
      print(path.codeUnits);
      // var file = path.codeUnits;
      try {
        RestOptions options = RestOptions(
            path: '$url',
            // content-type: 'Text/Plain',
            body:
            Uint8List.fromList(
                    '$path'
                    .codeUnits)
        );
        RestOperation restOp = Amplify.API.post(restOptions: options);
        RestResponse response = await restOp.response;
        print('POST call upload file succeeded');
      } on ApiException catch(e) {
        print('uploadFile Err: ' + e.toString());
    }
    } on ApiException catch(e) {
      print('get url Err: ' + e.toString());

    }
  }

  }

