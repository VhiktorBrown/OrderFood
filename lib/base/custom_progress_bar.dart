import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/utils/dimensions.dart';

import '../data/controllers/auth_controller.dart';
import '../utils/colors.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Print the Loading variable value - True of False
    print("Current state of Server Request" + Get.find<AuthController>().isLoading.toString());

    return Center(
      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.height20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20*5/2),
          color: AppColors.mainColor
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
