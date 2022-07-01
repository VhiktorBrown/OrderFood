import 'package:flutter/material.dart';
import 'package:order_food/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  int stars;

  AppColumn({Key? key, required this.text, this.stars=5}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
                children: List.generate(stars, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15,))
            ),
            SizedBox(width: Dimensions.height10,),
            SmallText(text: "4.5"),
            SizedBox(width: Dimensions.height10,),
            SmallText(text: "2345"),
            SizedBox(width: Dimensions.height10/2,),
            SmallText(text: "comments")
          ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndTextWidget(icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on,
                text: "1.7 km",
                iconColor: AppColors.mainColor),
            IconAndTextWidget(icon: Icons.access_time_rounded,
                text: "35 min",
                iconColor: AppColors.iconColor2),
          ],
        ),
      ],
    );
  }
}
