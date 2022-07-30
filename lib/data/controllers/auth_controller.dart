import 'package:get/get.dart';
import 'package:order_food/data/models/response_model.dart';

import '../models/User.dart';
import '../models/sign_up_body.dart';
import '../repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _loggedOut = false;
  bool get loggedOut => _loggedOut;

  late User _user;
  User get user => _user;

  Future<ResponseModel> registration(SignUpBody signUpBody) async{
    _isLoading = true;
    //inform UI that isLoading has been changed.
    update();

    Response response = await authRepo.registerUser(signUpBody);

    ResponseModel responseModel;
    if(response.statusCode == 200 || response.statusCode == 201){
      authRepo.saveToken(response.body["token"]);

      responseModel = ResponseModel(true, response.body["token"]);
    }else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    //update UI
    update();

    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async{
    _isLoading = true;
    //inform UI that isLoading has been changed.
    update();

    Response response = await authRepo.loginUser(email, password);

    ResponseModel responseModel;
    if(response.statusCode == 200 || response.statusCode == 201){

      //save Token to shared preferences and update headers.
      authRepo.saveToken(response.body["token"]);

      //save User Information to SharedPreferences
      authRepo.saveUserDetails(SignUpBody.fromJson(response.body["user"]));

      responseModel = ResponseModel(true, response.body["token"]);
    }else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    //update UI
    update();

    return responseModel;
  }

  //Function to fetch User's data
  Future<ResponseModel> fetchUserModel() async{

    ResponseModel responseModel;

    _isLoading = true;
    //inform UI that isLoading has been changed.
    update();

    Response response = await authRepo.getUser();

    if(response.statusCode == 200){
      _user = User.fromJson(response.body);
      update();

      print(response.body);

      responseModel = ResponseModel(true, "Gotten user successfully.");
    }else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    //update UI
    update();

    return responseModel;
  }

  //Function for Logging user out
  Future<bool> logout() async{
    _isLoading = true;
    //inform UI that isLoading has been changed.
    update();

    Response response = await authRepo.logoutUser();

    if(response.statusCode == 200){

      //remove UserDetails
      authRepo.clearUserData();

      _loggedOut = true;
      update();

    }else {
      _loggedOut = false;
      update();
    }
    _isLoading = false;
    //update UI
    update();

    print("LOGGED OUT: "+ _loggedOut.toString());
    return _loggedOut;
  }


  void saveUserDetails(SignUpBody signUpBody) async{
    authRepo.saveUserDetails(signUpBody);
  }

  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }

  bool clearUserData(){
    return authRepo.clearUserData();
  }
}