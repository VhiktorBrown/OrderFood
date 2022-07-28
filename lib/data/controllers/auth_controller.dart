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

    Response response = await authRepo.registerUser(signUpBody);

    ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveToken(response.body["token"]);

      responseModel = ResponseModel(true, response.body["token"]);
    }else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    //update UI
    update();

    return responseModel;
  }
}