import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order_food/base/custom_progress_bar.dart';
import 'package:order_food/pages/auth/sign_up.dart';

import '../../base/show_custom_snackbar.dart';
import '../../data/controllers/auth_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/text_field_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _loginUser(AuthController authController){

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      //check for Empty fields
      if(email.isEmpty){
        showCustomSnackBar("Kindly fill in your email", title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Kindly fill in a valid email", title: "Invalid Email");
      }else if(password.isEmpty){
        showCustomSnackBar("Kindly fill in your password", title: "Password");
      }else if(password.length < 6){
        showCustomSnackBar("Password has to be more than 6 characters", title: "Password too short");
      }else {

        //send User Details to the Server for Login
        authController.login(email, password).then((status) {
          if(status.success){
            print("Login Successful");
            //Get.toNamed(RouteHelper.getInitial());
            Get.offAndToNamed(RouteHelper.getInitial());
          }else {
            showCustomSnackBar(status.message, color: AppColors.mainColor, title: "Unsuccessful");
          }
        });

      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //Container showing Logo
              Container(
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.radius20*4,
                    backgroundImage: AssetImage(
                        "assets/images/order_food_logo.png"
                    ),
                  ),
                ),
              ),

              //Container showing Hello and other text
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome",
                      style: TextStyle(
                        fontSize: Dimensions.font20*2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Sign into your account",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),

              TextFieldWidget(textController: emailController, hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              TextFieldWidget(textController: passwordController, hintText: "Password", icon: Icons.password, isObscure: true,),
              SizedBox(height: Dimensions.height20,),

              //space between text above and sign in button
              SizedBox(height: Dimensions.screenHeight*0.05,),

              //Acts as the Sign in Button
              GestureDetector(
                onTap: (){

                  //validate data and attempt to log user in.
                  _loginUser(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                      child: BigText(text: "Sign in", size: Dimensions.font20, color: Colors.white,)
                  ),
                ),
              ),
              //space between sign in button and create account text
              SizedBox(height: Dimensions.screenHeight*0.05,),

              RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Dimensions.font20,
                    ),
                    children: [
                      TextSpan(
                        //when user taps on Create, it takes user to Sign up page
                          recognizer: TapGestureRecognizer()..onTap=()=> Get.to(SignUpPage(), transition: Transition.fade),
                          text: " Sign in.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor,
                            fontSize: Dimensions.font20,
                          ))
                    ],
                  )
              ),

              SizedBox(height: Dimensions.screenHeight*0.05,),

            ],
          ),
        )
            :const CustomProgress();
      },)
    );
  }
}
