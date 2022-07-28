import 'package:get/get_connect/http/src/response/response.dart';
import 'package:order_food/data/models/sign_up_body.dart';
import 'package:order_food/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registerUser(SignUpBody signUpBody) async{
    return await apiClient.postData(Constants.REGISTER_URL, signUpBody.toJson());
  }

  //save Token to Local Storage
  saveToken(String token) async {
    //initialize token in ApiClient class
    apiClient.token = token;

    //update Header
    apiClient.updateHeader();

    return await sharedPreferences.setString(Constants.TOKEN, token);
  }
}