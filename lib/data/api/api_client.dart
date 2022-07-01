import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/utils/constants.dart';

import '../../utils/colors.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = Constants.TOKEN;

    _mainHeaders = {
      'content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token'
    };
  }

  Future<Response> getData(String uri) async{
    try{
      Response response = await get(uri);
      return response;
    }catch(e){
      Get.snackbar("Unsuccessful", "Response was not successful",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);
      //TODO TO remove later
      print("RESPONSE UNSUCCESSFUL " + e.toString());

      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}