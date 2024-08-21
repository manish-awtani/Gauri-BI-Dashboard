import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpHandler {
    static Future<Map<String, String>> _getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString("TOKEN");

    // print("tokennnnn---$token");
    // if (token != null) {
    //   return {
    //     'Content-type': 'application/x-www-form-urlencoded',
    //     'Accept': "*/*",
    //     'token': token,
    //   };
    // } else {
      return {
        "accept": "*/*",
        "Content-Type": "application/json-patch+json"
      };
    // }
  }

  static Future<APIResponse> postMethod(
      {required String url,
      Map<String, dynamic>? data,
      required BuildContext context,
      }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("AUTOLOGINNNNNN$autologin");
    var header = await _getHeaders();
    // {'accept':'*/*','Content-Type':'application/json-patch'+'json'};
    
    // utologin ? await _getAutologinHeader() : await _getHeaders();
    // var userCode = prefs.getInt("user_code");
    // print("USER_CODEE$userCode");
    var finalUrl = url;
    // .contains('{usercode}')
    //     ? url.replaceAll('{usercode}', '$userCode').toString()
    //     : url;
    print("POST URL -- '$finalUrl'");
    print("POST DATA -- '$data'");
    print("POST HEADER -- '$header'");
      var body = json.encode(data);
    http.Response respond =
        await http.post(Uri.parse(finalUrl), 
        headers: header,
        body: body);

    print("respondddddddd ---- httphandler   ${respond}");

    print("POST RESPOND -- ${respond.body}");

    if (respond.statusCode == 200 || respond.statusCode == 401) {
      Map<String, dynamic> responseToMap = json.decode(respond.body);

      if (respond.statusCode == 200) {

        responseToMap.addAll({
          "StatusCode": responseToMap["status_code"],
          "Header": respond.headers,
          "IsSuccess": true,
          "Data": responseToMap["data"],
          "status_message": responseToMap["message"],
        });
      // print("POST responseToMap okkkk-- ${responseToMap} ----------");
        return APIResponse.fromJson(responseToMap);
      } else if (respond.statusCode == 401) {
        return APIResponse.fromJson(responseToMap);
      } else {
        responseToMap.addAll({
          "StatusCode": responseToMap["status_code"],
          "Header": respond.headers,
          "IsSuccess": false,
          "Data": responseToMap["data"],
          "status_message": responseToMap["message"],
        });
        return APIResponse.fromJson(responseToMap);
      }
    } else {
      // Map<String, dynamic> responseToMap = {};
      Map<String, dynamic> responseToMap = json.decode(respond.body);

      print("POST responseToMap -- $responseToMap");
      responseToMap.addAll({
        "StatusCode": responseToMap["code"],
        "Header": respond.headers,
        "IsSuccess": false,
        "Data": responseToMap["data"],
        "status_message": responseToMap["message"],
      });
      return APIResponse.fromJson(responseToMap);
    }
  }
}
