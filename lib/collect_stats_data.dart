import 'dart:ffi';
import 'dart:typed_data';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import './fetch_data.dart';
import 'dart:convert';

class Stats {
  Future<Map> getAllEmotions() async {
    String userId = await Fetch().fetchUserId();
    String res;
    List resList;
    Map ret;

    //try {
    RestOptions options = RestOptions(path: '/emotions/$userId');
    RestOperation restOperation = Amplify.API.get(restOptions: options);
    RestResponse response = await restOperation.response;

    res = String.fromCharCodes(response.data);
    resList = jsonDecode(res);
    //} on ApiException catch (err) {
    //  print('Error: failed to processs analysis data: $err');
    //}

    for (var i = 0; i < resList.length; i++) {
      ret[resList[i]["Date"]] = {
        "HappinessLevel": resList[i]["HappinessLevel"],
        "SadnessLevel": resList[i]["SadnessLevel"],
        "AngrinessLevel": resList[i]["AngrinessLevel"],
        "SurpriseLevel": resList[i]["SurpriseLevel"],
        "FearLevel": resList[i]["FearLevel"]
      };
    }

    return ret;
  }
}
