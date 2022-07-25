import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/big_text.dart';

import 'app_icon.dart';

class ProfileWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;

  ProfileWidget({Key? key, required this.appIcon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.height10,
        bottom: Dimensions.height10
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
          )
        ]
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          bigText
        ],
      ),
    );
  }
}
