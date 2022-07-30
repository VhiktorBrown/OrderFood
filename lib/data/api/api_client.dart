import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colors.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(Constants.TOKEN)??"";

    _mainHeaders = {
      'content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token'
    };
  }

  void updateHeader(token){
    //token has been updated upon Sign up in Auth Repo
    _mainHeaders = {
      'content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token'
    };
    //print("Token: " + token);
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async{
    try{
      Response response = await get(
          uri,
          headers: headers??_mainHeaders);

      return response;
    }catch(e){
      Get.snackbar("Unsuccessful", "Response was not successful",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);

      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async{
    try{
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}