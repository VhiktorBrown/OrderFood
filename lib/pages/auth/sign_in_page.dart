import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order_food/pages/auth/sign_up.dart';

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


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  Text("Hello",
                    style: TextStyle(
                      fontSize: Dimensions.font20*3,
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
            TextFieldWidget(textController: passwordController, hintText: "Password", icon: Icons.password),
            SizedBox(height: Dimensions.height20,),

            //text beneath password container
            Row(
              children: [
                Expanded(child: Container()),
                RichText(
                    text: TextSpan(
                        text: "sign into your account",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.font20,
                        )
                    )
                ),
                SizedBox(width: Dimensions.width20,),
              ],
            ),
            //space between text above and sign in button
            SizedBox(height: Dimensions.screenHeight*0.05,),

            //Acts as the Sign in Button
            Container(
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
                  text: " Create.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: Dimensions.font20,
                  ))
                  ],
                )
            ),

            SizedBox(height: Dimensions.screenHeight*0.05,),

          ],
        ),
      ),
    );
  }
}
