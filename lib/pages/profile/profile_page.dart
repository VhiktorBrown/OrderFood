import 'package:flutter/material.dart';
import 'package:order_food/data/controllers/cart_controller.dart';
import 'package:order_food/utils/colors.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/app_icon.dart';
import 'package:order_food/widgets/big_text.dart';
import 'package:order_food/widgets/profile_widget.dart';
import 'package:order_food/data/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../base/custom_progress_bar.dart';
import '../../routes/route_helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    //check if user is logged in before fetching user details
    if(userLoggedIn){
      Get.find<AuthController>().fetchUserModel();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: "Profile",
          size: Dimensions.iconSize24,
          color: Colors.white,),
      ),
      body: GetBuilder<AuthController>(builder: (authController){
        return userLoggedIn?
        (!authController.isLoading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //Profile image
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45+Dimensions.height30,
                size: Dimensions.height15*10,
              ),
              SizedBox(height: Dimensions.height30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Profile name
                      ProfileWidget(
                          appIcon: AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.iconSize24,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: authController.user.name!)),
                      SizedBox(height: Dimensions.height20,),

                      //Profile username
                      ProfileWidget(
                          appIcon: AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.iconSize24,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: authController.user.username!)),
                      SizedBox(height: Dimensions.height20,),

                      //Profile phone
                      ProfileWidget(
                          appIcon: AppIcon(
                            icon: Icons.phone,
                            backgroundColor: Colors.grey,
                            iconColor: Colors.white,
                            iconSize: Dimensions.iconSize24,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: authController.user.phone!,)),
                      SizedBox(height: Dimensions.height20,),

                      //Profile email
                      ProfileWidget(
                          appIcon: AppIcon(
                            icon: Icons.email,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.iconSize24,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: authController.user.email!,)),
                      SizedBox(height: Dimensions.height20,),

                      //Profile address
                      ProfileWidget(
                          appIcon: AppIcon(
                            icon: Icons.location_on,
                            backgroundColor: Colors.grey,
                            iconColor: Colors.white,
                            iconSize: Dimensions.iconSize24,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: "Fill in your address",)),
                      SizedBox(height: Dimensions.height20,),

                      //Profile message
                      ProfileWidget(
                          appIcon: AppIcon(
                            icon: Icons.message_outlined,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.iconSize24,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: "Messages",)),
                      SizedBox(height: Dimensions.height20,),

                      GestureDetector(
                        onTap: (){
                          //if user is logged in...
                          if(Get.find<AuthController>().userLoggedIn()){
                            print("Logging out..");
                            //log user out if user is logged in
                            Get.find<AuthController>().logout();

                              //clear Cart History
                              Get.find<CartController>().clear();
                              Get.find<CartController>().clearCartHistory();

                              //take user to Sign in Page..
                              Get.offNamed(RouteHelper.getSignInPage());

                          }else {
                            print("You are logged out..");
                          }
                        },
                        child: ProfileWidget(
                            appIcon: AppIcon(
                              icon: Icons.logout,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.iconSize24,
                              size: Dimensions.height10*5,),
                            bigText: BigText(text: "Logout",)),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
            :CustomProgress())
            :Container(child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*8,
                  margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "assets/images/login.png"
                        )

                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignInPage());
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20*3,
                    margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Center(child: BigText(text: "Sign in", color: Colors.white, size: Dimensions.font20)),
                  ),
                )
              ],
            )
        ),
      );
      },)
    );
  }
}
