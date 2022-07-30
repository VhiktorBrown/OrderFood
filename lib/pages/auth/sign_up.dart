import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/base/custom_progress_bar.dart';
import 'package:order_food/data/controllers/auth_controller.dart';
import 'package:order_food/data/models/sign_up_body.dart';
import 'package:order_food/routes/route_helper.dart';
import 'package:order_food/utils/colors.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/big_text.dart';
import 'package:order_food/widgets/text_field_widget.dart';
import 'package:order_food/base/show_custom_snackbar.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var usernameController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    var images = [
      "facebook(1).png",
      "twitter(1).png",
      "google(1).png"
    ];

    void _registerNewUser(AuthController authController){

      String name = nameController.text.trim();
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      //check for Empty fields
      if(name.isEmpty){
        showCustomSnackBar("Kindly fill in your name", title: "Name");
      }else if(username.isEmpty){
        showCustomSnackBar("Kindly fill in a username", title: "Username");
      }else if(phone.isEmpty){
        showCustomSnackBar("Kindly fill in your phone number", title: "Phone");
      }else if(email.isEmpty){
        showCustomSnackBar("Kindly fill in your email", title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Kindly fill in a valid email", title: "Invalid Email");
      }else if(password.isEmpty){
        showCustomSnackBar("Kindly fill in your password", title: "Password");
      }else if(password.length < 6){
        showCustomSnackBar("Password has to be more than 6 characters", title: "Password too short");
      }else {

        //create the Sign Up Object
        SignUpBody signUpBody = SignUpBody(
          name: name,
          username: username,
          email: email,
          phone: phone,
          password: password
        );

        //send User Details to the Server to Register
        authController.registration(signUpBody).then((status) {
          if(status.success){
            print("Registration Successful");
            showCustomSnackBar(status.message, color: AppColors.mainColor, title: "Successful");
            //take user to Main page of app
            Get.offNamed(RouteHelper.getInitial());
          }else {
            showCustomSnackBar(status.message, color: AppColors.mainColor, title: "Unsuccessful");
          }
        });

      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        //If Loading variable is false, show UI widgets, if not, show custom progress
        return !authController.isLoading?SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
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
              TextFieldWidget(textController: nameController, hintText: "Name", icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              TextFieldWidget(textController: usernameController, hintText: "Username", icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              TextFieldWidget(textController: emailController, hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              TextFieldWidget(textController: passwordController, hintText: "Password", icon: Icons.password, isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              TextFieldWidget(textController: phoneController, hintText: "Phone number", icon: Icons.phone),
              SizedBox(height: Dimensions.screenHeight*0.05,),

              GestureDetector(
                onTap: (){
                  _registerNewUser(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                      child: BigText(text: "Sign up", size: Dimensions.font20, color: Colors.white,)
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Have an account already?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.font20,
                      )
                  )
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),

              //Sign up with Google, Facebook, etc.
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Sign up with any of these..",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.font16,
                      )
                  )
              ),

              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/images/${images[index]}"
                    ),
                  ),
                )
                ),
              )
            ],
          ),
        )
            :const CustomProgress();
      },)
    );
  }
}
