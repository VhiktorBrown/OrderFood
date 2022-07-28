import 'package:get/get.dart';
import 'package:order_food/data/models/response_model.dart';

import '../models/sign_up_body.dart';
import '../repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

  void saveUserDetails(SignUpBody signUpBody) async{
    authRepo.saveUserDetails(signUpBody);
  }

  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }
}