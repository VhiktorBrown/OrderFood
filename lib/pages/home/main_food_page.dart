import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_food/utils/colors.dart';
import 'package:order_food/utils/dimensions.dart';
import 'package:order_food/widgets/big_text.dart';
import 'package:order_food/widgets/small_text.dart';

import '../../data/controllers/popular_products_controller.dart';
import '../../data/controllers/recommended_products_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {

  Future<void> _loadResources() async{
    //make calls to fetch our data
    await Get.find<PopularProductsController>().getPopularProductsList();
    await Get.find<RecommendedProductsController>().getRecommendedProductsList();
  }

  @override
  Widget build(BuildContext context) {
    //Added a Refresh Indicator Widget to support reloading of data
    return RefreshIndicator(onRefresh: _loadResources, child: Column(
      children: [
        Container(
          //displays the header of the page
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height45, right: Dimensions.width15),
            padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "United Kingdom", color: AppColors.mainColor,),
                    Row(
                      children: [
                        SmallText(text: 'Buckingham', color: Colors.black54,),
                        const Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.width45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.iconSize24,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10,),
        //displays the Body of the page, aside the header.
        const Expanded(child: SingleChildScrollView(
          child: FoodPageBody(),
        ),),
      ],
    ));
  }
}
