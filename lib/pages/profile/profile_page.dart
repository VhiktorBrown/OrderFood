import 'package:flutter/material.dart';
import 'package:order_food/utils/colors.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/app_icon.dart';
import 'package:order_food/widgets/big_text.dart';
import 'package:order_food/widgets/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: "Profile",
          size: Dimensions.iconSize24,
          color: Colors.white,),
      ),
      body: Container(
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
                        bigText: BigText(text: "Victor",)),
                    SizedBox(height: Dimensions.height20,),
                    //Profile phone
                    ProfileWidget(
                        appIcon: AppIcon(
                          icon: Icons.phone,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.iconSize24,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "08167945270",)),
                    SizedBox(height: Dimensions.height20,),
                    //Profile email
                    ProfileWidget(
                        appIcon: AppIcon(
                          icon: Icons.email,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.iconSize24,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "victor@syticks.com",)),
                    SizedBox(height: Dimensions.height20,),
                    //Profile address
                    ProfileWidget(
                        appIcon: AppIcon(
                          icon: Icons.location_on,
                          backgroundColor: AppColors.yellowColor,
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
                        bigText: BigText(text: "Message",)),
                    SizedBox(height: Dimensions.height20,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
