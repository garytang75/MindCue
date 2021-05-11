import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'dart:io';

class Journal {
  //get signed url from s3 and send audio file to s3
  void uploadFile(filePath) async {
    try {
      RestOptions options = RestOptions(
          path: '/aud/get_url',
          apiName: 'mc-api'
      );
      RestOperation restOperation = Amplify.API.get(
          restOptions: options
      );
      //get response and parse it
      RestResponse response = await restOperation.response;
      var finalres = json.decode(String.fromCharCodes(response.data));
      var data = finalres['fields'];
      var key = data['key'];
      var uploadUrl = "https://dev-mc-audio-storage.s3.amazonaws.com/";
      print('GET call getSignedUrl succeeded');
      //rename audio file
      var dir = path.dirname(filePath);
      var newPath = path.join(dir, key );
      File f = await File(filePath).copy(newPath);
      //form request data
      var formData = FormData.fromMap({
        'key': key,
        'AWSAccessKeyId': data['AWSAccessKeyId'],
        'x-amz-security-token': data['x-amz-security-token'],
        'policy': data['policy'],
        'signature': data['signature'],
        'file': f.path
      });
      //send audio upload POST request
      Dio dio = new Dio();
      Response s3response = await dio.post(uploadUrl, data: formData);
      int statusCode = s3response.statusCode;
      print("status code: " + statusCode.toString());

    } on ApiException catch(e) {
      print('get url Err: ' + e.toString());
    }
  }

}

