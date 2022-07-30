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

  Future<Response> loginUser(String email, String password) async{
    return await apiClient.postData(Constants.LOGIN_URL, {"email": email, "password": password});
  }

  Future<Response> getUser() async{
    return await apiClient.getData(Constants.FETCH_USER_URL);
  }

  Future<Response> logoutUser() async{

    //fetch Token from sharedPreferences
    String token = sharedPreferences.getString(Constants.TOKEN)!;

    return await apiClient.postData(Constants.LOGOUT_URL, {"token": token});
  }

  //Function that retrieves user Token
  Future<String> getUserToken() async{
    return await sharedPreferences.getString(Constants.TOKEN)??"NoToken";
  }

  bool userLoggedIn(){
    return sharedPreferences.containsKey(Constants.TOKEN);
  }

  //save Token to Local Storage
  saveToken(String token) async {
    //initialize token in ApiClient class
    apiClient.token = token;

    //update Header
    apiClient.updateHeader(token);

    return await sharedPreferences.setString(Constants.TOKEN, token);
  }

  Future<void> saveUserDetails(SignUpBody signUpBody) async{
    try{
      await sharedPreferences.setString(Constants.ID, signUpBody.id!);
      await sharedPreferences.setString(Constants.NAME, signUpBody.name!);
      await sharedPreferences.setString(Constants.USERNAME, signUpBody.username!);
      await sharedPreferences.setString(Constants.EMAIL, signUpBody.email!);
      await sharedPreferences.setString(Constants.PHONE, signUpBody.phone!);

      //TODO Remove later
      print(signUpBody.name! + signUpBody.username!);
    }catch(e){
      rethrow;
    }
  }

  bool clearUserData(){
    sharedPreferences.remove(Constants.ID);
    sharedPreferences.remove(Constants.NAME);
    sharedPreferences.remove(Constants.USERNAME);
    sharedPreferences.remove(Constants.EMAIL);
    sharedPreferences.remove(Constants.PHONE);

    //remove Token
    sharedPreferences.remove(Constants.TOKEN);
    print("removed TOKEN");

    //set token in API CLIENT
    apiClient.token = "";
    //update header with empty token
    apiClient.updateHeader("");
    return true;
  }
}